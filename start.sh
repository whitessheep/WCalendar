mkdir -p logs & mkdir -p tmp
echo "start"
openresty -p `pwd`/ -c conf/nginx-dev.conf
