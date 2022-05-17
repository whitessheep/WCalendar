apt-get -y install --no-install-recommends wget gnupg ca-certificates
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
apt-get update
apt-get -y install openresty 

type openresty >/dev/null 2>&1 || { echo >&2 "openresty 安装失败"; exit 1; }
type resty >/dev/null 2>&1 || { echo >&2 "resty 安装失败"; exit 1; }

type git >/dev/null 2>&1 || { echo >&2 "需要git依赖"; exit 1; }
git clone https://github.com/sumory/lor
cd lor
make install
type lord  >/dev/null 2>&1 || { echo >&2 "lord 安装失败"; exit 1; }

apt-get -y install uuid-dev 
type lord  >/dev/null 2>&1 || { echo >&2 "uuid 安装失败"; exit 1; }

echo “安装成功， 请导入数据库” 