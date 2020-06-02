class WeatherDaddy
  class << self

    def other_htmls

    end

    def other_texts
      wea_html = other_htmls.css(".wea-detail li")
      wea_html.search('.//span').remove
      wea_html.map(&:content)[2..-2]
    end

    def deliver_others
      other_texts.each do |text|
        subject = text.match(/.*\)/).to_s.strip + "天气"
        content = text.split("\n").map(&:strip).join("\n").squeeze
        sendmail(subject, content)
        sleep 30
      end
    end

  end
end
