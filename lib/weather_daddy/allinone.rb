class WeatherDaddy
  class << self

    def html
      Nokogiri::HTML(open("https://tianqi.2345.com/#{@area_pinyin}/#{@area_id}.htm"))
    end

    def html_1d
      Nokogiri::HTML(open("https://tianqi.2345.com/#{@area_pinyin}1d/#{@area_id}.htm"))
    end

    def html_today
      Nokogiri::HTML(open("https://tianqi.2345.com/today-#{@area_id}.htm"))
    end

    # ==================================================
    # ==================================================
    # ==================================================
    def alert_today
      alert_subject = html.css(".today-detail ul.real-air li")[1].content
      alert_link = "http://tianqi.2345.com/" + html.css(".today-detail ul.real-air li a")[1].attributes['href'].value

      page = Nokogiri::HTML(open(alert_link))
      alert_detail = page.css(".wea-warning").text.split("\n").map{ |e| e.strip }.reject(&:blank?)
      alert_message = page.css(".warn-stand").text.strip
      [ alert_subject,
        alert_message,
        { title: alert_detail[0],
          time: alert_detail[1],
          content: alert_detail[2] } ]
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
            map{ |e| e.split("\n \n ").reject(&:blank?) }.
            map{ |e| [ e[0].gsub("\n", "").gsub(" ", ""), e[1..-1].join(" ").gsub("\n", "") ] }.
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

    # ==================================================
    # ==================================================
    # ==================================================
    def sendmail_livetips
      livetips.each do |k, v|
        sendmail("今日#{k}", v)
        sleep 10
      end
    end

    def sendmail_alert
      subject, body, detail = alert_today
      sendmail("今日#{subject}", body)
    end

    def sendmail_wea_trend
      sendmail("未来天气趋势", wea_trend)
    end

    def sendmail_weas
      weas_15days.each do |k, v|
        subject = case k
                  when /(今天|昨天|明天)/
                    "#{k.first(2)}天气"
                  when /(周)/
                    "#{k.last(4)}天气"
                  end
        sendmail(subject, v)
        sleep 10
      end
    end

  end
end