Local_IP="$( /sbin/ifconfig -a|grep inet|grep -i 192.168|grep -v inet6|awk '{print $2}'|tr -d "addr:" )"
echo "Local_IP=$Local_IP"

Hostname="$( hostname )"
echo "Hostname=$Hostname"

Applications=$0
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
echo "AppDir=$Applications"

WorkDir=$Applications/docxinshi/docker-test/dev_docxinshi_nginx

Docker_name=dev_docxinshi_nginx
docker stop $Docker_name
docker rm $Docker_name
docker run -it \
--name $Docker_name \
--restart=always \
--ulimit core=0 \
--log-driver none \
--net=host \
-v $Applications:/Applications \
-v $WorkDir/Documents:/Documents \
-v $WorkDir/System:/System \
prod_centos_hk \
sh /Applications/docxinshi/shell/dev/_nginx/_nginx.sh