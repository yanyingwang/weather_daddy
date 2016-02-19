require 'open-uri'
require 'nokogiri'
require 'pony'

require 'active_support/all'
require "weather_daddy/version"



class WeatherDaddy
  @recipient = "*@139.com"
  @username = ""
  @password = ""
  @area_id = "60687"  # 河南新郑
  #@area_id = "58362"  # 上海

  @regex_pars =  /(气温|风力|湿度|日出|日落)/


  class << self
    private

    def int_to_day_of_week(num)
      case num
      when 0 then '周日'
      when 1 then '周一'
      when 2 then '周二'
      when 3 then '周三'
      when 4 then '周四'
      when 5 then '周五'
      when 6 then '周六'
      end
    end

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


