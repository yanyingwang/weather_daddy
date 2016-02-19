require 'open-uri'
require 'nokogiri'
require 'pony'

require "weather_daddy/version"



class WeatherDaddy
  @recipient = "*@139.com"
  @username = ""
  @password = ""
  @area_id = "60687"  # 河南新郑
  #@area_id = "58362"  # 上海


  class << self
    private
    def sendmail(subject, content)
      Pony.mail({ :from => @username + "@qq.com",
                  :to => @recipient,
                  :via => :smtp,
                  :subject => subject,
                  :body => content,
                  :via_options => { :address        => 'smtp.qq.com',
                                    :port           => '25',
                                    :user_name      => @username,
                                    :password       => @password,
                                    :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                                    :domain         => "localhost.localdomain" } })
    end

  end
end



require "weather_daddy/today"
require "weather_daddy/tomorrow"
require "weather_daddy/week"


