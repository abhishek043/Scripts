#!/bin/bash

podname=$1
namespace=$2
localpath=/Users/abhishek

kubectl exec  $podname --namespace=$namespace -- bash -c "pid=\$(ps -aux|grep java|grep /kohls/config/application/ | awk '{print \$2}'|sed -n 1p) && \
jmap -dump:format=b,file=filename.hprof \$pid"
echo "Heap dump is taken successfully.Now copying the dump to:" $localpath
kubectl cp $namespace/$podname:/filename.hprof $localpath/$podname.hprof
echo "Copying finished."
