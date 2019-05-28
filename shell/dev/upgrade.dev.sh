ENV_FILE=dev/env.dev.sh

CurrentDir=$0
CurrentDir="$( cd "$( dirname $CurrentDir  )" && pwd  )"
echo "CurrentDir=$CurrentDir"

source $CurrentDir/../$ENV_FILE

docker exec -it $Docker_name sh $AppRoot/shell/_/_upgrade.sh 

