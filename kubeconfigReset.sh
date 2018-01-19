#!/bin/sh

RED='\033[0;31m'
NC='\033[0m' 

contextName=`kubectl config current-context`
echo "Current Kube Conext found:" ${RED}$contextName${NC}
echo "-----------------------------------------"

echo "Trying to delete the Current Context"
deleteContext=`kubectl config delete-context $contextName`

if [ $? -eq 0 ]; then
    echo "-----------------------------------------"
    echo "Context ${RED}$contextName${NC} Deleted Successfully"
    echo "-----------------------------------------"
else
    echo "-----------------------------------------"
    echo "FAILED to delete context:${RED}$contextName${NC}"
    echo "-----------------------------------------"
fi


