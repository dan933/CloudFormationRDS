#!/bin/sh

source ../cfg.sh

if [ -z $Action ]; then

    	echo "Usage: sh cfg12.sh <create|update|delete>"

elif [ $Action == 'create' ]; then

  aws cloudformation create-stack \
    --stack-name $Stack12Parameter \
    --template-body file://cf12.yaml \
    --parameters \
    ParameterKey=VPCStackParameter,ParameterValue=$Project \
    ParameterKey=DBNameParameter,ParameterValue=$DBNameParameter \
    ParameterKey=DBUsernameParameter,ParameterValue=$DBUsernameParameter \
    ParameterKey=DBPasswordParameter,ParameterValue=$DBPasswordParameter \
    ParameterKey=DBTypeParameter,ParameterValue=$DBTypeParameter \
    ParameterKey=DBEngineParameter,ParameterValue=$DBEngineParameter \
    ParameterKey=DBVersionParameter,ParameterValue=$DBVersionParameter \
    ParameterKey=DBZoneParameter,ParameterValue=$DBZoneParameter \
    ParameterKey=DBStorageParameter,ParameterValue=$DBStorageParameter \
    --region $Region
    
elif [ $Action == 'update' ]; then

      aws cloudformation update-stack \
        --stack-name $Stack12Parameter \
        --template-body file://cf12.yaml \
        --parameters \
        ParameterKey=VPCStackParameter,ParameterValue=$Project \
        ParameterKey=DBNameParameter,ParameterValue=$DBNameParameter \
        ParameterKey=DBUsernameParameter,ParameterValue=$DBUsernameParameter \
        ParameterKey=DBPasswordParameter,ParameterValue=$DBPasswordParameter \
        ParameterKey=DBTypeParameter,ParameterValue=$DBTypeParameter \
        ParameterKey=DBEngineParameter,ParameterValue=$DBEngineParameter \
        ParameterKey=DBZoneParameter,ParameterValue=$DBZoneParameter \
        ParameterKey=DBStorageParameter,ParameterValue=$DBStorageParameter \
        --region $Region
    
elif [ $Action == 'delete' ]; then

    aws cloudformation delete-stack \
        --stack-name $Stack12Parameter \
        --region $Region

else

	echo "Usage: sh cfg12.sh <create|update|delete>"

fi