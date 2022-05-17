mkdir -p logs & mkdir -p tmp
echo "reload"
openresty -s reload -p `pwd`/ -c conf/nginx-dev.conf
