
class WeatherDaddy
  class << self

    def today_html
      Nokogiri::HTML(open("https://tianqi.2345.com/today-#{@area_id}.htm"))
    end

    def today_arr
      today_arr = []

      today_html.css(".time-main dl.day").each { |e| today_arr << e.content.gsub("今日", "") }
      today_html.css(".time-main dl.night").each { |e| today_arr << e.content.gsub("今日", "") }
      today_html.css("ul.parameter li").each { |e| today_arr << e.content if e.content =~ @regex_pars }

      today_arr
    end

    def today_txt
      today_arr.join("\n").gsub("：", "").gsub("风力 ", "").gsub("风向 ", "")
    end

    def day_of_week_today
      int_to_day_of_week Time.now.wday
    end

    def deliver_today_normal
      sendmail("今日(#{day_of_week_today})天气", today_txt)
    end


    def alert_title
      today_html.css(".emoticon").text
    end

    def alert_content
      links = today_html.css(".emoticon a#alertLink")

      if links.empty?
        return [ today_html.css("ul.lifeindex li")[1].content,
                 today_html.css("ul.lifeindex li")[2].content,
                 today_html.css("ul.lifeindex li")[3].content,
                 today_html.css("ul.lifeindex li")[4].content,
                 today_html.css("ul.lifeindex li")[6].content, ].join("").gsub(" ", ":").gsub("。", "\n")
      end

      link_alert = links.first.attributes["href"].value
      html_alert = Nokogiri::HTML(open("http://tianqi.2345.com/" + link_alert))

      content_arr = html_alert.css(".news-text p").text.split("：")
      content_time = Time.new(*content_arr.first.match(/....年..月..日/).to_s.split(/[年月日]/))
      content_text = content_arr.second

      content_time.day == Time.now.day ? content_text : nil
    end

    def deliver_alert
      sendmail(alert_title, alert_content) if alert_content
    end

    def deliver_today
      deliver_today_normal
      sleep 10
      deliver_alert
    end

  end
end
