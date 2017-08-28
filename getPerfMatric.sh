#!/bin/bash

timestamp=`date`
tps=$1
zone="US-East"

mui_namespace="mui-prod"
msp_namespace="msp-prod"
ingress_namespace="ingress-prod"
payment_namespace="payment-prod"
browse_namespace="browse-prod"
encryption_namespace="encryption-prod"
loyalty_namespace="loyalty-prod"

mui_deployment=$2
ingress_deployment=$3
msp_deployment=$4
browse_deployment=$5
enc_deployment=$6
loyalty_deployment=$7

echo "sh getkpidata.sh <tps> <mui-dep> <ingress-dep> <msp-dep> <browse-dep> <encryption-dep> <loyalty-dep>"

echo "Timestamp,Service,No of pods,CPU in %,Memory in (MB),Total TPS" >> perf_metric_$timestamp.csv
echo "--------------------------------------------------------------------------------------------------------------"
echo "Current running tps:"$tps
echo "MUI" $zone "data is recorded at:"$timestamp
mui_cpu=`kubectl get hpa --namespace $mui_namespace |grep $mui_deployment|awk '{print $3}'`
mui_mem=`kubectl top pod --namespace $mui_namespace|grep $mui_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
mui_pods=`kubectl get hpa --namespace $mui_namespace |grep $mui_deployment|awk '{print $8}'`
echo $timestamp",$mui_deployment,$mui_pods,$mui_cpu,$mui_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------------------------------------"
echo "Ingress" $zone "data is recorded at:"$timestamp
ingress_cpu=`kubectl get hpa --namespace $ingress_namespace |grep $ingress_deployment|awk '{print $3}'`
ingress_mem=`kubectl top pod --namespace $ingress_namespace|grep $ingress_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
ingress_pods=`kubectl get hpa --namespace $ingress_namespace|grep $ingress_deployment|awk '{print $8}'`
echo $timestamp",$ingress_deployment,$ingress_pods,$ingress_cpu,$ingress_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------------------------------------"
echo "MSP" $zone "data is recorded at:"$timestamp
msp_cpu=`kubectl get hpa --namespace $msp_namespace |grep $msp_deployment|awk '{print $3}'`
msp_mem=`kubectl top pod --namespace $msp_namespace|grep $msp_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
msp_pods=`kubectl get hpa --namespace $msp_namespace|grep $msp_deployment|awk '{print $8}'`
echo $timestamp",$msp_deployment,$msp_pods,$msp_cpu,$msp_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------------------------------------"
echo "Browse" $zone "data is recorded at:"$timestamp
browse_cpu=`kubectl get hpa --namespace $browse_namespace |grep $browse_deployment|awk '{print $3}'`
browse_mem=`kubectl top pod --namespace $browse_namespace|grep $browse_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
browse_pods=`kubectl get hpa --namespace $browse_namespace|grep $browse_deployment|awk '{print $8}'`
echo $timestamp",$browse_deployment,$browse_pods,$browse_cpu,$browse_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------------------------------------"
echo "Encryption" $zone "data is recorded at:"$timestamp
enc_cpu=`kubectl get hpa --namespace $encryption_namespace |grep $enc_deployment|awk '{print $3}'`
enc_mem=`kubectl top pod --namespace $encryption_namespace|grep $enc_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
enc_pods=`kubectl get hpa --namespace $encryption_namespace|grep $enc_deployment|awk '{print $8}'`
echo $timestamp",$enc_deployment,$enc_pods,$enc_cpu,$enc_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------------------------------------"
echo "Loyalty" $zone "data is recorded at:"$timestamp
loy_cpu=`kubectl get hpa --namespace $loyalty_namespace |grep $loyalty_deployment|awk '{print $3}'`
loy_mem=`kubectl top pod --namespace $loyalty_namespace|grep $loyalty_deployment |awk '{print $3}'|sed "s/[^0-9]//g"|sort -nr|head -n1`
loy_pods=`kubectl get hpa --namespace $loyalty_namespace|grep $loyalty_deployment|awk '{print $8}'`
echo $timestamp",$loyalty_deployment,$loy_pods,$loy_cpu,$loy_mem,$tps" >> perf_metric_$timestamp.csv
echo "---------------------------------------------------------------------------------------------------------------"

