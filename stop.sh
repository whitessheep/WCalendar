mkdir -p logs & mkdir -p tmp
echo "stop"
openresty -s stop -p `pwd`/ -c conf/nginx-dev.conf
