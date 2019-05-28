redis_name=redis1-master

CurrentDir=$0
CurrentDir="$( cd "$( dirname $CurrentDir  )" && pwd  )"
echo "CurrentDir=$CurrentDir"

Local_IP="$( /sbin/ifconfig -a|grep inet|grep -i 192.168|grep -v inet6|awk '{print $2}'|tr -d "addr:" )"
echo "Local_IP=$Local_IP"

master_IP="$( docker inspect --format='{{.NetworkSettings.IPAddress}}' $redis_name)"
echo "master_IP=$master_IP"

Applications=$0
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
echo "AppDir=$Applications"

Docker_name="sentinel-master"
redis="$HOME/work/gitlab/redis/redis1-master"

mkdir -p $redis/data/
mkdir -p $redis/conf/

docker stop $Docker_name
docker rm $Docker_name
docker run -it \
--name $Docker_name \
--restart=always \
--ulimit core=0 \
--log-driver none \
-p 8001:26379 \
-v $redis/data:/data \
-v $redis/conf/sentinel:/etc/redis/sentinel \
--env Local_IP=$Local_IP \
--env ENV_FILE=$ENV_FILE \
redis:3.2 \
redis-sentinel /etc/redis/sentinel/sentinel.conf