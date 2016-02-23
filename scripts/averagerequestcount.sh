#!/bin/bash
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

starttime=`date -u +"%Y-%m-%dT%H:%M:%S"`
endtime=`date -u +"%Y-%m-%dT%H:%M:%S" --date '+1 minute'`
echo "st : $starttime"
echo "et : $endtime"

healthycount=`aws cloudwatch get-metric-statistics --namespace "AWS/ELB" --metric-name HealthyHostCount --dimensions Name=LoadBalancerName,Value=abc --statistics Average --start-time $starttime --end-time $endtime --period 60 --region us-east-1 | awk ' /'Average'/ {print +$2}'`
echo "hc : $healthycount"

totalrequests=`aws cloudwatch get-metric-statistics --namespace "AWS/ELB" --metric-name RequestCount --dimensions Name=LoadBalancerName,Value=abc --statistics Sum --start-time $starttime --end-time $endtime --period 60 --region us-east-1 | awk ' /'Sum'/ {print +$2}'`
echo "tr : $totalrequests"

avgRequests=$(($totalrequests/$healthycount))

echo "AR : $avgRequests"
aws cloudwatch put-metric-data --metric-name avgReq --namespace "Pramati/AvgReq" --value $avgRequests
