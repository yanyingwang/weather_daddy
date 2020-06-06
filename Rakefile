#!/usr/bin/env ruby


require_relative 'lib/weather_daddy'


# usage example: $ rake deliver_today

task :deliver_all do
  WeatherDaddy.sendmail_weas
  sleep 10
  WeatherDaddy.sendmail_wea_trend
  sleep 10
  WeatherDaddy.sendmail_livetips
  sleep 10
  WeatherDaddy.sendmail_alert
end


task :sendmail_weas do
  WeatherDaddy.sendmail_weas
end

task :sendmail_wea_trend do
  WeatherDaddy.sendmail_wea_trend
end

task :sendmail_alert do
  WeatherDaddy.sendmail_alert
end

task :sendmail_livetips do
  WeatherDaddy.sendmail_livetips
end


# task :deliver_today do
#   WeatherDaddy.deliver_today
# end

# task :deliver_tomorrow do
#   WeatherDaddy.deliver_tomorrow
# end


# task :deliver_others do
#   WeatherDaddy.deliver_others
# end
