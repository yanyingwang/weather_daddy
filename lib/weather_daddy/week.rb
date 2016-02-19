
class WeatherDaddy
  class << self

    def html_weekdays
      Nokogiri::HTML(open("http://tianqi.2345.com/xinzheng/#{area_id}.htm"))
    end

    def arr_weekdays
      arr_week = []

      html_week.css(".week.week_day7 li").each { |e| arr_week << e.content unless e.content =~ /天气详情/ }
    end


    def mail_weekdays
      arr_week.each do |day|
        day_arr = day.split("\n")
        sub = day_arr.shift.strip + "天气"
        content = day_arr.join("\n").gsub("：", "")

        sendmail(sub, content)
        sleep 2
      end
    end

  end
end
