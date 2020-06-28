require 'open-uri'
require 'open_uri_redirections'

class WeatherDaddy
  class << self

    def html
      Nokogiri::HTML(open("https://tianqi.2345.com/#{@area_pinyin}/#{@area_id}.htm", :allow_redirections => :all))
    end

    def html_1d
      Nokogiri::HTML(open("https://tianqi.2345.com/#{@area_pinyin}1d/#{@area_id}.htm", :allow_redirections => :all))
    end

    def html_today
      Nokogiri::HTML(open("https://tianqi.2345.com/today-#{@area_id}.htm", :allow_redirections => :all))
    end

    # ==================================================
    # ==================================================
    # ==================================================
    def alerts_today
      oos = html.css(".today-detail ul.real-air li").select { |e| e.content =~ /预警/ }
      oos.map do |e|
        subject = e.content
        link = "http://tianqi.2345.com/" + e.css("a").first.attributes['href'].value
        page = Nokogiri::HTML(open(link))
        detail = page.css(".wea-warning").text.split("\n").map{ |e| e.strip }.reject(&:blank?)
        message = page.css(".warn-stand").text.strip
        { subject: subject,
          message: message,
          detail: { title: detail[0],
                    time: detail[1],
                    content: detail[2] } }
      end
    end

    def wea_today
      a = html.css(".today-detail a.all-day-info")[0].text.gsub(" ", "").gsub("\n", "")
      b = html.css(".today-detail a.all-day-info")[1].text.gsub(" ", "").gsub("\n", "")
      data = html.css(".today-detail ul.real-data").text.gsub("\n", " ").squeeze.split(" ")
      [a, b, data]
    end

    def weas_7days
      h = html_today.css("ul.wea-white-icon").text.
            strip.squeeze(" ").split("\n \n \n \n").
            map{ |e| e.split("\n \n ").reject(&:blank?) }.
            map{ |e| [ e[0].gsub("\n", "").gsub(" ", ""), e[1..-1].join(" ").gsub("\n", "") ] }.
            to_h
    end

    # {"06/27昨天休"=>"阴转雷阵雨 23~32° 东南风2级 良(空气)",
    #  "06/28今天班"=>"阴转多云 21~27° 东南风2级 优(空气)",
    #  "06/29明天"=>"晴 22~32° 东风2级 优(空气)",
    #  "06/30周二"=>"晴转多云 21~30° 东北风3级 优(空气)",
    #  "07/01周三"=>"多云 22~30° 东北风3级 优(空气)",
    #  "07/02周四"=>"多云 22~31° 东风2级 优(空气)",
    #  "07/03周五"=>"多云转阴 22~30° 东风2级 优(空气)",
    #  "07/04周六"=>"小雨 24~29° 东南风3级 优(空气)",
    #  "07/05周日"=>"中雨 21~31° 西南风3级 优(空气)",
    #  "07/06周一"=>"中雨转多云 20~31° 东南风3级 优(空气)",
    #  "07/07周二"=>"多云转中雨 21~32° 东北风2级 优(空气)",
    #  "07/08周三"=>"中雨 22~35° 南风3级 优(空气)",
    #  "07/09周四"=>"晴转多云 22~33° 南风3级 良(空气)",
    #  "07/10周五"=>"中雨转多云 20~31° 南风3级 良(空气)",
    #  "07/11周六"=>"多云 21~31° 南风4级 良(空气)",
    #  "07/12周日"=>"多云转阴 22~33° 西南风3级 良(空气)"}
    def weas_15days
      h = html.css("ul.wea-white-icon").text.
            strip.squeeze(" ").split("\n \n \n \n").
            map{ |e| e.split("\n \n ").reject(&:blank?) }.
            map{ |e| [ e[0].gsub("\n", "").gsub(" ", ""), e[1..-1].join(" ").gsub("\n", "").gsub("查看天气详情", "").strip + "(空气)" ] }.
            to_h
    end

    def wea_trend
      html.css(".fifty-all-info").text.strip
    end

    # {"天气舒适"=>"建议穿长袖牛仔裤等服装。",
    #  "无需带伞"=>"外出时无需带雨伞。",
    #  "少发感冒"=>"发生感冒机率较低。",
    #  "较适宜晨练"=>"气象条件会对晨练影响不大。",
    #  "紫外线很弱"=>"您无需担心紫外线。",
    #  "较不宜晾晒"=>"天气阴沉，不太适宜晾晒。",
    #  "适宜开车"=>"天气很好，适宜正常行驶。",
    #  "较不宜洗车"=>"您的爱车可能会蒙上污垢。",
    #  "不适宜旅游"=>"天气很差，不适宜旅游。",
    #  "不适宜钓鱼"=>"气象条件不利于钓鱼。"}
    def livetips
      h = html_1d.css("ul.live-tips-box").text.
            strip.squeeze(" ").split("\n \n \n \n").
            map{ |e| e.split("\n \n").map(&:strip) }[0..-2].
            map{ |e| e.first =~ /钓/ ? [e.first, e.third ] : [e.first, e.second ] }.
            to_h
    end

    def sun_today
      html_1d.css(".hours24-data-th-right").text.strip.split("\n").map { |e| e.gsub(" ", "") }
    end

    # ==================================================
    # ==================================================
    # ==================================================
    def sendmail_livetips
      s, m = livetips.first
      sendmail("今日#{s}", m)
      # livetips.each do |k, v|
      #   sendmail("今日#{k}", v)
      #   sleep 10
      # end
    end

    def sendmail_alert
      alerts_today.each do |e|
        subject, body = e[:subject], e[:message]
        sendmail("今日#{subject}", body)
      end
    end

    def sendmail_wea_trend
      sendmail("今日未来天气趋势", wea_trend)
    end

    def sendmail_sun
      sendmail("今日太阳", sun_today.join(" "))
    end

    def sendmail_weas
      weas_15days.to_a[1..7].to_h.each do |k, v|
        subject = "#{k}天气"
        sendmail(subject, v)
        sleep 10
      end
    end

  end
end