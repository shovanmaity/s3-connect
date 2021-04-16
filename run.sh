#! /usr/bin/env sh

# url -> s3 server url
# region -> region name
# bucket -> bucket name
# key -> key or path inside s3 bucket

# id -> access id or username
# secret -> secret or password

# path -> path inside pod/vm (local path)
while getopts i:s:u:r:b:k:p: flag
do
    case ${flag} in
        i) id=${OPTARG};;
        s) secret=${OPTARG};;
        u) url=${OPTARG};;
        r) region=${OPTARG};;
        b) bucket=${OPTARG};;
        k) key=${OPTARG};;
        p) path=${OPTARG};;
    esac
done

id=$(echo ${id} | xargs)
secret=$(echo ${secret} | xargs)

url=$(echo ${url} | xargs)
region=$(echo ${region} | xargs)
bucket=$(echo ${bucket} | xargs)
key=$(echo ${key} | xargs)

path=$(echo ${path} | xargs)

usage() {
cat << EOF
-i -> access id or username
-s -> secret or password
-u -> s3 server url
-r -> region name
-b -> bucket name
-k -> key or path inside s3 bucket
-p ->  path inside pod/vm (local path)
use -
run.sh \
  -i minioadmin \
  -s minioadmin \
  -u http://192.168.0.190:9000 \
  -r us-east-1 \
  -b b-001 \
  -k / \
  -p /tmp
EOF
}

validate_id() {
if [ -z ${id} ]
then
  echo "missing id"
  usage;
  exit 1;
fi
}

validate_secret() {
if [ -z ${secret} ]
then
  echo "missing secret"
  usage;
  exit 1;
fi
}

validate_url() {
if [ -z ${url} ]
then
  echo "missing url"
  usage;
  exit 1;
fi
}

validate_region() {
if [ -z ${region} ]
then
  echo "missing region name"
  usage;
  exit 1;
fi
}

validate_bucket() {
if [ -z ${bucket} ]
then
  echo "missing bucket name"
  usage;
  exit 1;
fi
}

validate_key() {
if [ -z ${key} ]
then
  echo "missing key"
  usage;
  exit 1;
fi
}

validate_path() {
if [ -z ${path} ]
then
  echo "missing destination (local path)"
  usage;
  exit 1;
fi
}

sync() {
  AWS_ACCESS_KEY_ID=${id} \
  AWS_SECRET_ACCESS_KEY=${secret} \
  AWS_REGION=${region} \
  aws --endpoint-url ${url} s3 cp s3://${bucket}${key} ${path} --recursive
}

validate_id;
validate_secret;
validate_url;
validate_bucket;
validate_region;
validate_key;
validate_path;
sync;
