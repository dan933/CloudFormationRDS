#!/bin/sh

source ../cfg.sh

if [ -z $Action ]; then

        echo "Usage: sh cfg01.sh <create|update|delete>"

elif [ $Action == 'create' ]; then

        aws cloudformation create-stack \
                --stack-name $Stack1Parameter \
                --template-body file://cf01.yaml \
                --parameters \
                ParameterKey=Stack1Parameter,ParameterValue=$Stack1Parameter \
                ParameterKey=VPCRegionParameter,ParameterValue=$VPCRegionParameter \
                ParameterKey=CidrBlockParameter,ParameterValue=$CidrBlockParameter \
                ParameterKey=AZ1Parameter,ParameterValue=$AZ1Parameter \
                ParameterKey=CidrBlockPub1Parameter,ParameterValue=$CidrBlockPub1Parameter \
                ParameterKey=AZ2Parameter,ParameterValue=$AZ2Parameter \
                ParameterKey=CidrBlockPub2Parameter,ParameterValue=$CidrBlockPub2Parameter
                --region $Region

elif [ $Action == 'update' ]; then

        aws cloudformation update-stack \
                --stack-name $Stack1Parameter \
                --template-body file://cf01.yaml \
                --parameters \
                ParameterKey=Stack1Parameter,ParameterValue=$Stack1Parameter \
                ParameterKey=VPCRegionParameter,ParameterValue=$VPCRegionParameter \
                ParameterKey=CidrBlockParameter,ParameterValue=$CidrBlockParameter \
                ParameterKey=AZ1Parameter,ParameterValue=$AZ1Parameter \
                ParameterKey=CidrBlockPub1Parameter,ParameterValue=$CidrBlockPub1Parameter \
                ParameterKey=CidrBlockPri1Parameter,ParameterValue=$CidrBlockPri1Parameter \
                ParameterKey=AZ2Parameter,ParameterValue=$AZ2Parameter \
                ParameterKey=CidrBlockPub2Parameter,ParameterValue=$CidrBlockPub2Parameter \
                ParameterKey=CidrBlockPri2Parameter,ParameterValue=$CidrBlockPri2Parameter \
                ParameterKey=FlowlogBucketParameter,ParameterValue=$FlowlogBucketParameter \
                ParameterKey=FlowlogBucketARNParameter,ParameterValue=$FlowlogBucketARNParameter \
                --region $Region

elif [ $Action == 'delete' ]; then

        aws cloudformation delete-stack \
                --stack-name $Stack1Parameter \
                --region $Region
        echo "Deleting Stack"

else

        echo "Usage: sh cfg01.sh <create|update|delete>"

fi