<img src="https://raw.githubusercontent.com/yanyingwang/weather_daddy/master/favicon.png" alt="favicon" width="120"/>



# WeatherDaddy
孝敬省吃俭用的父母的天气预报短信通知程序。





## 更新
因为2345页面改版，重写本应用，使用说明如下：

~~~ruby
➜  weather_daddy git:(master) ✗ ./bin/console
Frame number: 0/0

[1] pry(main)> WeatherDaddy.weas_15days
=> {"昨天06/05"=>"阴转晴 23~34° 东风3级 良",
 "今天06/06"=>"多云 23~36° 东南风3级 良",
 "明天06/07"=>"多云 22~36° 东南风3级 优",
 "周一06/08"=>"多云转阴 26~36° 东南风3级 优",
 "周二06/09"=>"小雨转中雨 23~34° 东北风3级 优",
 "周三06/10"=>"小雨转晴 22~29° 西北风2级 优",
 "周四06/11"=>"晴转阴 24~33° 北风3级 优",
 "周五06/12"=>"中雨转晴 21~28° 东北风2级 优",
 "周六06/13"=>"阴转多云 21~35° 南风2级 优",
 "周日06/14"=>"晴转阴 23~36° 东风3级 优",
 "周一06/15"=>"中雨转多云 26~35° 东南风3级 优",
 "周二06/16"=>"中雨 26~36° 东南风2级 优",
 "周三06/17"=>"中雨转阴 23~32° 东北风2级 优",
 "周四06/18"=>"多云转晴 23~36° 东北风2级 优",
 "周五06/19"=>"多云转阴 23~37° 东北风3级 优",
 "周六06/20"=>"阴 21~33° 北风3级 轻度"}

[2] pry(main)>
[3] pry(main)> WeatherDaddy.wea_today
=> ["今天白天多云36°", "今天夜间多云23°", ["南风 3级", "湿度 32%", "气压 989hPa", "日出 05:12", "日落 19:35", "紫外线 极强"]]

[4] pry(main)> WeatherDaddy.weas_7days
=> {"昨天06/05阴转晴"=>"23~34° 东风3级 良",
 "今天06/06多云"=>"23~36° 东南风3级 良",
 "明天06/07多云"=>"22~36° 东南风3级 优",
 "周一06/08多云转阴"=>"26~36° 东南风3级 优",
 "周二06/09小雨转中雨"=>"23~34° 东北风3级 优",
 "周三06/10小雨转晴"=>"22~29° 西北风2级 优",
 "周四06/11晴转阴"=>"24~33° 北风3级 优",
 "周五06/12中雨转晴"=>"21~28° 东北风2级 优",
 "现在"=>"南风 3级 轻度",
 "14:00"=>"东南风 3级 良",
 "15:00"=>"东南风 4级 良",
 "16:00"=>"东南风 4级 优",
 "17:00"=>"东南风 4级 优",
 "18:00"=>"东南风 4级 优",
 "19:00"=>"东南风 3级 优",
 "20:00"=>"东南风 3级 优",
 "21:00"=>"南风 3级 优",
 "22:00"=>"西南风 3级 优",
 "23:00"=>"西南风 3级 优",
 "06/07"=>"西南风 3级 优",
 "01:00"=>"西南风 3级 优",
 "02:00"=>"西南风 3级 优",
 "03:00"=>"西南风 2级 优",
 "04:00"=>"西南风 2级 优",
 "05:00"=>"南风 2级 优",
 "06:00"=>"南风 2级 优",
 "07:00"=>"东南风 2级 良",
 "08:00"=>"东南风 3级 良",
 "09:00"=>"东南风 3级 良",
 "10:00"=>"东南风 3级 良",
 "11:00"=>"东南风 4级 良",
 "12:00"=>"东南风 4级 优"}
[5] pry(main)>
[6] pry(main)>

[7] pry(main)> WeatherDaddy.alert_today
=> {:alert_subject=>"高温预警",
 :alert_message=>"24小时内最高气温将升至37℃以上。",
 :alert_detail=>
  {:title=>"河南省郑州市气象台发布高温橙色预警",
   :time=>"2020-06-06 09:05 更新",
   :content=>"郑州市气象台2020年06月06日09时05分发布高温橙色预警信号：预计6月6日和7日郑州市区及所辖六县（市）午后最高气温将升至37℃以上,请注意防范。（预警信息来源：国家预警信息发布中心）"}}

[8] pry(main)>
[9] pry(main)>
[10] pry(main)> WeatherDaddy.livetips
=> {"天气炎热"=>"建议穿薄型T恤短裤等夏装。",
 "无需带伞"=>"外出时无需带雨伞。",
 "少发感冒"=>"发生感冒机率较低。",
 "较适宜晨练"=>"气象条件会对晨练影响不大。",
 "紫外线中等"=>"外出需要涂抹中倍数防晒霜。",
 "适宜晾晒"=>"天气不错，适宜晾晒衣物。",
 "适宜开车"=>"天气很好，适宜正常行驶。",
 "较不宜洗车"=>"您的爱车可能会蒙上污垢。",
 "适宜旅游"=>"天气较好，适宜旅游。",
 "较适宜钓鱼"=>"气象条件对钓鱼影响不大。"}

[11] pry(main)> WeatherDaddy.wea_trend
=> "3天降温/2天升温，20天有雨"
~~~



## 说明和感谢
本项目的天气数据来源于[2345天气预报](http://tianqi.2345.com/)，如果您喜欢，欢迎下载他们的[手机APP软件](http://tianqi.2345.com/tianqiapp/)。

本项目仅供测试使用，如有侵犯您的权益，请联系作者删除。



## 使用前设置
1. area_id获取：先登陆[2354天气预报网](http://tianqi.2345.com/)，找到您所需预报的天气区域ID，例如河南省新郑市的页面 http://tianqi.2345.com/xinzheng/60687.htm 的area_id即为**60687**。
2. QQ邮箱发邮件：您需要有一个QQ邮箱账号，用来发送邮件。
3. 中国移动139邮箱开启全天邮件到短信通知。
4. pull code
```shell
git clone https://github.com/yanyingwang/weather_daddy.git

cd weather_daddy

mkdir logs
```


## 配置
两个方式配置：

1. configure it via shell var:
~~~shell
WD_RECIPIENT="phone_num@139.com"
WD_USERNAME="usrname" # @qq.com
WD_PASSWORD="password" # username@qq.com's password
WD_AREA_ID="60687"  # 河南新郑
~~~

2. configure it via ruby file:
~~~shell
cat >> lib/config.rb <<EOF
class WeatherDaddy
  @recipient = "phone_num@139.com"
  @username = "usrname"
  @password = "password"
  @area_id = "60687"  # 河南新郑
end
EOF
~~~


## 命令发送天气短信
```shell
rake deliver_all
# rake deliver_today
# rake deliver_tomorrow
# rake deliver_others
```


## crontab自动任务发送天气短信
使用如下命令可以更新crontab，自动发送天气短信：

    $ whenever -i

## 通过github action的schedule来自动发送
1. 到repo的`Settings` -> `Secrets`的页面上增加`WD_AREA_ID` `WD_PASSWORD` `WD_RECIPIENT` `WD_USERNAME`这几个变量。
2. 可以修改`.github/workflows/deliver-sms.yml`中schedule的时间来自定义发送时间。

## 通过gitlab-ci的schedule来自动发送
1. 到repo的`settings`->`ci`->`Environment variables`的页面上设置设置好变量`WD_AREA_ID` `WD_PASSWORD` `WD_RECIPIENT` `WD_USERNAME`的值。
2. 到repo的`CI/CD`->`Schedules`的`New Schedule`建立好任务，并且传入variable： `TZ`值例如为`Asia/Shanghai`。
3. 如果需要，请修改定制化repo根目录下的`.gitlab-ci.yml`文件内容。



##  最后，容朕秀一张效果图，可好？ - > -
![list](https://raw.githubusercontent.com/yanyingwang/weather_daddy/master/screenshots/1.png)
