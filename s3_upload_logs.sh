#!/bin/bash
################
#Author :Krati
#Description: This script is used to upload logs to S3 bucket
################

# Set variables
LOG_DIR=~/.jenkins
S3_BUCKET_NAME=jenkins-logs-s3-upload
DATE=$(date +%Y-%m-%d-%H-%M-%S)

#check if aws cli is installed
if ! command -v aws &> /dev/null
then
    echo "aws cli could not be found, please install it and configure it with your AWS credentials"
    exit
fi

# Iterate through all job directories and upload logs to S3 bucket
for JOB_DIR in $LOG_DIR/jobs/*; do
    if [ -d "$JOB_DIR" ]; then
        JOB_NAME=$(basename "$JOB_DIR")

        # Iterate through all build directories for the current job
        for BUILD_DIR in "$JOB_DIR"/builds/*; do
            if [ -d "$BUILD_DIR" ]; then
                BUILD_NUMBER=$(basename "$BUILD_DIR")
                LOG_FILE="$BUILD_DIR/log"

                # Check if log file exists and was created today
                if [ -f "$LOG_FILE" ] && [ "$(date -r "$LOG_FILE" +%Y-%m-%d)" == "$(date +%Y-%m-%d)" ]; then
                    # Upload log file to S3 bucket with build number and date in the file name                                  
                    aws s3 cp "$LOG_FILE" "s3://$S3_BUCKET_NAME/$JOB_NAME/$BUILD_NUMBER/log-$DATE.txt"
                    echo "Uploaded $LOG_FILE to s3://$S3_BUCKET_NAME/$JOB_NAME/$BUILD_NUMBER/log-$DATE.txt"
                fi
            fi
        done
    fi
done    