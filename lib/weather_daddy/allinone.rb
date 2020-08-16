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
    def weas_15days
      h = html.css("ul.wea-white-icon").text.
            strip.squeeze(" ").split("\n \n \n \n").
            map{ |e| e.split("\n \n ").reject(&:blank?) }.reject(&:blank?).
            map{ |e| [ e[0].gsub("\n", "").gsub(" ", ""), e[1..-1].join(" ").gsub("\n", "").gsub("查看天气详情", "").strip + "(空气)" ] }.
            to_h
    end

    def wea_trend
      html.css(".fifty-all-info").text.strip
    end
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