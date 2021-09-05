#!/bin/sh

# The action passed in from the CLI - create, update or delete
Action=$1

# Project handle (lowercase a-z)
# Used extensively to name CF stacks, buckets, DNS zones, SSH keys, etc.
Project="VPCStackProject"

# The AWS region
Region="us-east-1"

# SSH key for EC2 instance creation and access (keyname without ".pem")
EC2KeyParameter="${Project}ec2"

# SSH key for Git access from EC2 instances (must be a key pair, not PEM file)
SSHKeyParameter="id_rsa"

# Nginx custom AMI image ID
NginxAmiId="ami-abcdefgh12345678"

# Registered domain
# Subdomains: www, wwwdev, api, apidev
DomainName="example.com.au"
HostedZoneId="Z12345678ABCDEFG"

# S3 bucket DNS zone info
# https://docs.aws.amazon.com/general/latest/gr/s3.html#s3_website_region_endpoints
# S3HostedZoneId="Z1ABCDEFGHIJKL"
S3DNSName="www.example.com.au-ap-southeast-2.amazonaws.com"

# CloudFront DNS zone info
# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-aliastarget.html
CFHostedZoneId="Z2FDTNDATAQYW2"

## Certificates
WWWCertificateArn="arn:aws:acm:us-east-1:123456789012:certificate/abcdefgh-1234-1234-1234-abcdefghijkl"
WWWDevCertificateArn="arn:aws:acm:us-east-1:123456789012:certificate/abcdefgh-1234-1234-1234-abcdefghijkl"

# Database details
DBUsername='dbuser'
DBPassword='dbpass'
DBName="dbname"
DBType="db.t3.xlarge"
DBEngine="sqlserver-se"
DBVersion="15.00.4073.23.v1"
DBZone="ap-southeast-2a"
DBStorage="20"
DBSql="s3://bucket.name/db.sql"
#DBWriterDNS="db.abcdefghijkl.ap-southeast-2.rds.amazonaws.com"

#######################################
# cf01.yaml: VPC
#######################################
Stack1Parameter="${Project}" # lowercase
VPCRegionParameter="${Region}"
CidrBlockParameter="172.26.0.0/24"
AZ1Parameter="${Region}a"
CidrBlockPub1Parameter="172.26.0.0/27"
CidrBlockPri1Parameter="172.26.0.32/27"
AZ2Parameter="${Region}b"
CidrBlockPub2Parameter="172.26.0.64/27"
CidrBlockPri2Parameter="172.26.0.96/27"
FlowlogBucketParameter="${Project}.flowlogs"
FlowlogBucketARNParameter="arn:aws:s3:::${FlowlogBucketParameter}"

#######################################
# cf02.yaml: S3 static hosting bucket
#######################################
Stack2Parameter="${Project}2"
DomainNameParameter="$DomainName"
HostingBucketParameter="www.${DomainName}"
HostingBucketARNParameter="arn:aws:s3:::${HostingBucketParameter}"
S3HostedZoneIdParameter="$S3HostedZoneId"
S3DNSNameParameter="$S3DNSName"

#######################################
# cf03.yaml: S3 file storage bucket
#######################################
Stack3Parameter="${Project}3"
FilesBucketParameter="${Stack1Parameter}.files"
FilesBucketARNParameter="arn:aws:s3:::${FilesBucketParameter}"

#######################################
# cf04.yaml: EC2 web server instance
#######################################
Stack4Parameter="${Project}4"
NginxAZParameter="AZ1Parameter"
NginxTypeParameter="t2.micro"

#######################################
# cf05.yaml: EFS Filesystem
#######################################
Stack5Parameter="${Project}5"
MountTarget1Parameter="172.26.0.62"
MountTarget2Parameter="172.26.0.126"

#######################################
# cf06.yaml: Cloud9 admin machine
#######################################
Stack6Parameter="${Project}6"

#######################################
# cf07.yaml: ELB + Autoscaling
#######################################
Stack7Parameter="${Project}7"
AMIParameter=$NginxAmiId
KeynameParameter=$EC2KeyParameter
CPUPolicyParameter="50"

#######################################
# cf08.yaml: EC2 Database
#######################################
Stack8Parameter="${Project}8"

#######################################
# cf09.yaml: EC2 Database
#######################################
Stack9Parameter="${Project}9"

#######################################
# cf10.yaml: Certificates (ELB)
#######################################
Stack10Parameter="${Project}10"

#######################################
# cf11.yaml: NAT Gateway
#######################################
Stack11Parameter="${Project}11"

#######################################
# cf12.yaml: Database
#######################################
Stack12Parameter="${Project}12"
DBNameParameter=$DBName
DBUsernameParameter=$DBUsername
DBPasswordParameter=$DBPassword
DBTypeParameter=$DBType
DBEngineParameter=$DBEngine
DBVersionParameter=$DBVersion
DBZoneParameter=$DBZone
DBStorageParameter=$DBStorage
