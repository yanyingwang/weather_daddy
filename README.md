# WeatherDaddy
孝敬省吃俭用的父母的天气预报短信通知程序。



## 说明和感谢

本项目的天气数据来源于[2345天气预报](http://tianqi.2345.com/)，如果您喜欢，欢迎下载他们的[手机APP软件](http://tianqi.2345.com/tianqiapp/)。

本项目仅供测试使用，如有侵犯您的权益，请联系作者删除。



## 使用前设置

1. area_id获取：先登陆[2354天气预报网](http://tianqi.2345.com/)，找到您所需预报的天气区域ID，例如河南省新郑市的页面 http://tianqi.2345.com/xinzheng/60687.htm 的area_id即为**60687**。
2. QQ邮箱发邮件：您需要有一个QQ邮箱账号，用来发送邮件。
3. 中国移动139邮箱开启全天邮件到短信通知。


## 配置

依次执行如下命令，注意修改`config.rb`文件的变量参数：

```shell
git clone https://github.com/yanyingwang/weather_daddy.git

cd weather_daddy

mkdir logs

cat >> lib/config.rb <<EOF
class WeatherDaddy
  @recipient = "phone_num@139.com"
  @username = "usrname"
  @password = "password"
  @area_id = "60687"  # 河南新郑
end
EOF
```

## 命令发送天气短信
```shell
rake deliver_today
rake deliver_tomorrow
rake deliver_others
```


## crontab自动任务发送天气短信

使用如下命令可以更新crontab，自动发送天气短信：

    $ whenever -i



##  最后，容朕秀一张效果图，可好？ - > -
![list](https://raw.githubusercontent.com/yanyingwang/weather_daddy/master/screenshots/1.png)
