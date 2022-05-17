# add the yum repo:
wget https://openresty.org/package/centos/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the yum index:
sudo yum check-update
sudo yum install -y openresty
sudo yum install -y openresty-resty
type openresty >/dev/null 2>&1 || { echo >&2 "openresty 安装失败"; exit 1; }
type resty >/dev/null 2>&1 || { echo >&2 "resty 安装失败"; exit 1; }

type git >/dev/null 2>&1 || { echo >&2 "需要git依赖"; exit 1; }
git clone https://github.com/sumory/lor
cd lor
make install
type lord  >/dev/null 2>&1 || { echo >&2 "lord 安装失败"; exit 1; }

sudo yum install -y libuuid-devel
type lord  >/dev/null 2>&1 || { echo >&2 "uuid 安装失败"; exit 1; }

echo “安装成功， 请导入数据库” 