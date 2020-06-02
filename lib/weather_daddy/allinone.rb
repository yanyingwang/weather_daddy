class WeatherDaddy
  class << self

    def html
      Nokogiri::HTML(open("https://tianqi.2345.com/xinzheng/60687.htm"))
    end

    def weas
      html.css("ul.wea-white-icon").text.squeeze.split("\n \n \n \n").reject{ |e| e =~ /昨天/ or e.blank? }.map { |e| e.gsub("\n", "").squeeze }
    end

    def deliver_all
      weas.each do |txt|
        arr = txt.split(" ")
        subject, body = case arr.first
                        when "今天"
                          ["今天天气", html.css(".today-detail a.all-day-info").text.gsub("\n", " ").squeeze.split(" ").join("") + " " + arr[4] + " " + html.css(".today-detail ul.real-air").text.gsub("\n", " ").squeeze.split(" ").last ]
                        when "明天"
                          ["明天天气", arr[2..-2].join(" ") ]
                        else
                          [arr[1] + "天气", arr[2..-2].join(" ") ]
                        end
        sendmail(subject, body)
        sleep 10
      end
    end

  end
end