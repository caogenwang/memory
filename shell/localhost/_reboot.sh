CurrentDir=$0
CurrentDir="$( cd "$( dirname $CurrentDir  )" && pwd  )"
echo "CurrentDir=$CurrentDir"

source $CurrentDir/../$ENV_FILE

cd $AppRoot && mix phx.server