
class WeatherDaddy
  class << self

    def others_html
      Nokogiri::HTML(open("https://tianqi.2345.com/xinzheng/#{@area_id}.htm"))
    end

    def others_arr
      others_arr = []

      others_html.css(".week.week_day7 li").each { |e| others_arr << e.content unless e.content =~ /天气详情/ }

      others_arr
    end


    def deliver_others
      others_arr.each do |day|
        day_arr = day.split("\n")
        sub = day_arr.shift.strip + "天气"
        content = day_arr.join("\n").gsub("：", "")

        sendmail(sub, content)
        sleep 10
      end
    end

  end
end
