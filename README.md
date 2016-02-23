# AWS-AvgELBReqCount
Cloudwatch custom metric for average requests for ELB.This script has to run as a cron job  to push custom metric to cloudwatch.
This is useful for autoscaling instances based on the number of requests ELB is receiving and number of healthy hosts.

Pre-Requisite 
##############
Aws Cli installed and configured.


