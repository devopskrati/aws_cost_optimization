# aws_cost_optimization

So this is a script that will help in uploading Jenkins Logs to S3 bucket.

In my company we were stuck into one issue where the cost was very high as one of our development team was using ELK stack for storing Jenkins and other applications and infra logs. They reached out to us for a solution. 
When we went deep into the problem we found that the Jenkins logs are the one that were actually creating this issue because their Jenkins setup was for multiple envs and each day they were running almost 1000 builds. We asked if they wants these logs for any anlysis or what
They confirm they are storing logs in Elasticsearch only for backup.

So we suggested them that we will get the Jenkins logs stored in S3 bucket using Deep Archive and Intelligent tiering. This will reduce almost 50% cost.
