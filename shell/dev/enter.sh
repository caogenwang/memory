ENV_FILE=dev/env.board.dev.sh

CurrentDir=$0
CurrentDir="$( cd "$( dirname $CurrentDir  )" && pwd  )"
echo "CurrentDir=$CurrentDir"

source $CurrentDir/../$ENV_FILE

Local_IP="$( /sbin/ifconfig -a|grep inet|grep -i 192.168|grep -v inet6|awk '{print $2}'|tr -d "addr:" )"
echo "Local_IP=$Local_IP"

Applications=$0
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
Applications="$( cd "$( dirname $Applications  )" && pwd  )"
echo "AppDir=$Applications"

Version="$(cat $Applications/$AppPath/_build/$env/version)"
tarFile=$Applications/$AppPath/_build/$env/release/$AppName/releases/$Version/$AppName.tar.gz
if [ -f "$tarFile" ]; then
    echo "$tarFile exist"
else
    echo "$tarFile not exist"
    exit
fi

function create() {
Docker_name=$1
WorkDir=$2
echo "WorkDir=$WorkDir"
mkdir -p $WorkDir

docker run -it \
--rm \
--ulimit core=0 \
--log-driver none \
--net=host \
-v $Applications:/Applications \
-v $Applications/pdf2htmlEX:/Applications/pdf2htmlEX \
-v $Applications/pdf2htmlEX/poppler-data:/usr/local/share/poppler \
-v $WorkDir/Documents:/Documents \
-v $WorkDir/System:/System \
-v /etc/:/etc/ \
--env Local_IP=$Local_IP \
--env ENV_FILE=$ENV_FILE \
prod_centos_hk \
/bin/bash
}

create $Docker_name $Applications/$AppPath/docker-test/$Docker_name

