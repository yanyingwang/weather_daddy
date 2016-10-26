

class WeatherDaddy
  class << self

    def tomorrow_html
      Nokogiri::HTML(open("https://tianqi.2345.com/tomorrow-#{@area_id}.htm"))
    end

    def tomorrow_arr
      tomorrow_arr = []

      tomorrow_html.css(".time-main dl.day").each { |e| tomorrow_arr << e.content.gsub("明日", "")  }
      tomorrow_html.css(".time-main dl.night").each { |e| tomorrow_arr << e.content.gsub("明日", "") }
      tomorrow_html.css("ul.parameter li").each { |e| tomorrow_arr << e.content if e.content =~ @regex_pars }

      tomorrow_arr
    end

    def tomorrow_txt
      tomorrow_arr.join("\n").gsub("：", "").gsub("风力 ", "")
    end


    def day_of_week_tomorrow
      int_to_day_of_week 1.days.from_now.wday
    end

    def deliver_tomorrow
      sendmail("明日(#{day_of_week_tomorrow})天气", tomorrow_txt)
    end

  end
end
