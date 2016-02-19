
class WeatherDaddy
  class << self

    def today_html
      Nokogiri::HTML(open("http://tianqi.2345.com/today-#{@area_id}.htm"))
    end

    def today_arr
      today_arr = []

      today_html.css(".time-main dl.day").each { |e| today_arr << e.content.gsub("今日", "") }
      today_html.css(".time-main dl.night").each { |e| today_arr << e.content.gsub("今日", "") }
      today_html.css("ul.parameter li").each { |e| today_arr << e.content if e.content =~ @regex_pars }

      today_arr
    end

    def today_txt
      today_arr.join("\n").gsub("：", " ")
    end

    def day_of_week_today
      int_to_day_of_week Time.now.wday
    end

    def today_deliver
      sendmail("今日(#{day_of_week_today})天气", today_txt)
    end


    def today_alert_title
      today_html.css(".emoticon").text
    end

    def today_alert_content
      links = today_html.css(".emoticon a#alertLink")

      return alert_title if links.empty?

      link_alert = links.first.attributes["href"].value
      html_alert = Nokogiri::HTML(open("http://tianqi.2345.com/" + link_alert))

      html_alert.css(".news-text p").text
    end

    def today_alert_deliver
      sendmail(alert_title, alert_content)
    end

  end
end
