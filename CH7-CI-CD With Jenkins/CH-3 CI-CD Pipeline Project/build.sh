docker build -t $JOB_NAME:$BUILD_ID .

docker tag $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:$BUILD_ID

docker tag $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:latest

docker push kartikjain26/$JOB_NAME:$BUILD_ID

docker push kartikjain26/$JOB_NAME:latest

docker rmi -f $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:latest
