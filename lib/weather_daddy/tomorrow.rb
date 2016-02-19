

class WeatherDaddy
  class << self

    def html_tomorrow
      Nokogiri::HTML(open("http://tianqi.2345.com/tomorrow-#{@area_id}.htm"))
    end

    def arr_tomorrow
      arr_tomorrow = []

      html_tomorrow.css(".time-main dl.day").each { |e| arr_tomorrow << e.content.gsub("明日", "")  }
      html_tomorrow.css(".time-main dl.night").each { |e| arr_tomorrow << e.content.gsub("明日", "") }
      html_tomorrow.css("ul.parameter li").each { |e| arr_tomorrow << e.content if e.content =~ /(气温|风力|湿度|降水|日出|日落)/ }

      arr_tomorrow
    end

    def txt_tomorrow
      arr_tomorrow.join("\n").gsub("：", " ")
    end

    def mail_tomorrow
      sendmail("明日天气", txt_tomorrow)
    end

  end
end
