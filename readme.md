# S3-sync
Using S3-sync we can download a full single bucket or a part of a bucket in our local volume.

Run MinIO docker image in local.
```bash
docker run -p 9000:9000 \
  -e "MINIO_ROOT_USER=minioadmin" \
  -e "MINIO_ROOT_PASSWORD=minioadmin" \
  minio/minio server /data
```

Create a bucket caller _b-001_ and inside this bucket create a sub dir _s-001_ and the dump some data at _/_ path of the bucket and sub dir of that bucket.

Download full _b-001_ bucket using
```bash
docker run -ti --rm quay.io/shovanmaity/s3-sync:latest \
  '-u http://192.168.0.190:9000' \
  '-i minioadmin' '-s minioadmin' \
  '-r us-east-1' \
  '-b b-001' \
  '-p /mnt' \
  '-k /'
```

Download _s-01_ dir in _b-001_ bucket using
```bash
docker run -ti --rm quay.io/shovanmaity/s3-sync:latest \
  '-u http://192.168.0.190:9000' \
  '-i minioadmin' '-s minioadmin' \
  '-r us-east-1' \
  '-b b-001' \
  '-p /mnt' \
  '-k /s-01'
```
