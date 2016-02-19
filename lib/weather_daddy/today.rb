
class WeatherDaddy
  class << self

    def html_today
      Nokogiri::HTML(open("http://tianqi.2345.com/today-#{@area_id}.htm"))
    end

    def arr_today
      arr_today = []

      html_today.css(".time-main dl.day").each { |e| arr_today << e.content.gsub("今日", "") }
      html_today.css(".time-main dl.night").each { |e| arr_today << e.content.gsub("今日", "") }
      html_today.css("ul.parameter li").each { |e| arr_today << e.content if e.content =~ /(气温|风力|湿度|日出|日落)/ }

      arr_today
    end

    def txt_today
      arr_today.join("\n").gsub("：", " ")
    end

    def mail_today
      sendmail("今日天气", txt_today)
    end


    def alert_title
      html_today.css(".emoticon").text 
    end

    def alert_content
      links = html_today.css(".emoticon a#alertLink")

      return alert_title if links.empty?

      link_alert = links.first.attributes["href"].value
      html_alert = Nokogiri::HTML(open("http://tianqi.2345.com/" + link_alert))

      html_alert.css(".news-text p").text
    end

    def mail_alert
      sendmail(alert_title, alert_content)
    end

  end
end
