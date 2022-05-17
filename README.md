# WCalendar

* 教学日历管理系统，针对教学日历编写工作提供信息化辅助手段，帮助教务部门和教师提高工作质量和效率，实现便捷而有效的管理。
* 项目采用Lua语言编写，后端基于OpenResty，前端采用bootstrap框架以及JavaScript，数据库使用的是Mysql

### 安装

- 安装前置OpenResty，lor，保证nginx -v; luajit -v; lord -v; 正常输出
	- 可以使用一键安装脚本install(xx).sh
	- 若安装失败，则到对应的网站安装
		- ①[OpenResty](http://openresty.org/cn/)
		- ②[lor](https://github.com/sumory/lor)
		- ③uuid apt-get -y install uuid-dev 
- 将仓库中提供的calendar.sql导入到MySQL, 在app/config/config.lua文件下面配置用户名(user), 密码(password), 数据库名(database).
- 配置静态文件目录，这个目录用于存放用户上传的头像、文章图片、评论图片等
	- 默认的目录为/app/static/image，请在保证本地有此目录，并保证该目录有供应用访问和修改的权限
	- 若要修改上述默认目录，请修改app/config/config.lua中的upload_config.dir和nginx配置文件中的$static_files_path的值，保证两个值一致
- 执行`sh start.sh`启动
- 访问`http://localhost:7888`
- 初始账户admin 密码均为123

### 自定义配置

- 系统的自定义配置路径在(app/config/config.lua), 里面有详细的注释
	- 白名单配置
	- 静态模板配置
	- 加密方案配置
	- Mysql配置
	- 上传文件路径配置
	- ...
- Nginx的配置在(conf/nginx-dev.conf)
	- 监听端口配置(:7888)
	- 日志保存路径配置
	- ...

### 操作

- ./start.sh   	启动服务器
- ./reload.sh  	热更代码
- ./stop.sh    	停止服务器
- ./log.sh 	 	查看滚动日志（error）
