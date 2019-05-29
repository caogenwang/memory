CurrentDir=$0
CurrentDir="$( cd "$( dirname $CurrentDir  )" && pwd  )"
echo "CurrentDir=$CurrentDir"

Local_IP="$( /sbin/ifconfig -a|grep inet|grep -i 192.168|grep -v inet6|awk '{print $2}'|tr -d "addr:" )"
echo "Local_IP=$Local_IP"

Applications=$0
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
echo "AppDir=$Applications"

Docker_name="redis1-master"
redis="$HOME/work/gitlab/redis/redis1-master"

mkdir -p $redis/data/
mkdir -p $redis/conf/

docker stop $Docker_name
docker rm $Docker_name
docker run -d \
--name $Docker_name \
--restart=always \
--ulimit core=0 \
--log-driver none \
-p 7001:6379 \
-v $redis/data:/data \
-v $redis/conf/redis.conf:/etc/redis/redis.conf \
--env Local_IP=$Local_IP \
--env ENV_FILE=$ENV_FILE \
redis:3.2 \
--bind 0.0.0.0 \
--requirepass 123456 \
--protected-mode no \
--masterauth 123456 \