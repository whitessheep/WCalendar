### 安装

- 安装前置OpenResty，lor，保证nginx -v; luajit -v; lord -v; 正常输出
	- 可以使用一键安装脚本
	- 若安装失败，则到对应的网站安装
		- ①[OpenResty](http://openresty.org/cn/)
		- ②[lor](https://github.com/sumory/lor)
		- ③uuid apt-get -y install uuid-dev 
- 将仓库中提供的install中的sql导入到MySQL
- 配置静态文件目录，这个目录用于存放用户上传的头像、文章图片、评论图片等
	- 默认的目录为/app/static/image，请在保证本地有此目录，并保证该目录有供应用访问和修改的权限
	- 若要修改上述默认目录，请修改app/config/config.lua中的upload_config.dir和nginx配置文件中的$static_files_path的值，保证两个值一致
- 执行`sh start.sh`启动
- 访问`http://localhost:8888`
- 初始账户admin 密码均为123456， 其他账号的密码也全为123456


