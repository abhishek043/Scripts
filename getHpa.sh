#!/bin/bash
msp_timestamp=`date`
tps=$1
echo "tps:"$tps
echo "MSP Central data is recorded at:"$msp_timestamp
kubectl get hpa --namespace msp-prod |grep msp-13

echo "---------------------------------------------------------------------------------------------------------------"

mui_timestamp=`date`
kubectl get hpa --namespace mui-prod |grep mui-521
echo "MUI Central data is recorded at:" $mui_timestamp

echo "----------------------------------------------------------------------------------------------------------------"

ingress_timestamp=`date`
kubectl get hpa --namespace ingress-prod |grep ingress-7
echo "Ingress Central data is recorded at:" $ingress_timestamp

