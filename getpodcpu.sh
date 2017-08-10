#!/bin/bash

#sudo apt-get install bc -y
podName=$1
nameSpace=$2

dat=`date +"%Y-%m-%d_%H"`
#podCount=`kubectl get pod $podName --namespace $nameSpace|grep -v READY|wc -l`
#echo "Number of pods running: $podCount"

healthypod=`kubectl get pods --namespace $nameSpace|grep -v NAME| wc -l`
echo "Total healthy pods in $nameSpace is : $healthypod"


cpuUsage=`kubectl top pod $podName --namespace $nameSpace| awk {'print $2'}|grep -v CPU|sed "s/[^0-9]//g"`
echo "Current cpu used in MB: $cpuUsage"

memUsage=`kubectl top pod $podName --namespace $nameSpace| awk {'print $3'}|grep -v MEMORY|sed "s/[^0-9]//g"`
echo "Current Mem used in MB:$memUsage"

cpuRequested=`kubectl describe pod $podName --namespace $nameSpace|grep cpu| head -2|tail -1| awk {'print $2'} | sed "s/[^0-9]//g"`
echo "CPU requested: $cpuRequested"

#memRequested=`kubectl describe pod $podName --namespace $nameSpace| grep memory| head -1| tail -1| awk {'print $2'} | sed "s/[^0-9]//g"`
#echo "Memory requested: $memRequested"

if [[ "$memRequested" =~ "Gi" ]]; then
    echo "Size is given in GB"
	memRequested=`kubectl describe pod $podName --namespace $nameSpace| grep memory| head -2| tail -1| awk {'print $2'} | sed "s/[^0-9]//g"`
	memRequested=$memRequested * 1024
	echo "Memory requested in MB: $memRequested"
else
	memRequested=`kubectl describe pod $podName --namespace $nameSpace| grep memory| head -2| tail -1| awk {'print $2'} | sed "s/[^0-9]//g"`
	echo "Memory requested in MB: $memRequested"
fi

echo "CPU usage of the pod"
cpuavg=`echo "scale=5; $cpuUsage/$cpuRequested" | bc -l` 
echo "cpu avg: $cpuavg"

echo "Mem usage of the pod"
memavg=`echo "scale=5; $memUsage/$memRequested" | bc -l`
#echo "scale=5; $memUsage/$memRequested" | bc -l 
echo "Mem avg: $memavg"

if [[ "$nameSpace" =~ "-" ]]; then
	servicename=`echo $nameSpace | cut -d'-' -f 1`
else
	servicename=$nameSpace
fi	


echo `date` >> usagelog_$dat.csv
echo "Microservice,Avg CPU in %, Avg Memory in %,No of healthy pods" >> usagelog_$dat.csv
#echo "US-East,US-East,US-East" >> usagelog_$dat.csv
echo "$servicename,$cpuavg,$memavg,$healthypod" >> usagelog_$dat.csv


