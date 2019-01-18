#PROJECT NAME
PROJECT_NAME=${PWD##*/}
#IMAGE NAME
TEST_IMAGE_NAME="$PROJECT_NAME:test"
#CONTAINER NAME
TEST_CONTAINER_NAME="test-$PROJECT_NAME"

MONGODB_DIR="$(pwd)/mongodb"

if [[ ! -e $MONGODB_DIR ]]; then
    mkdir $MONGODB_DIR
fi

if $(docker ps -a | grep -q ${TEST_CONTAINER_NAME}); then 
    docker stop ${TEST_CONTAINER_NAME}
fi

if $(docker ps -a | grep -q $TEST_CONTAINER_NAME); then
    docker rm $TEST_CONTAINER_NAME
fi

if [[ "$(docker images -q $TEST_IMAGE_NAME 2> /dev/null)" != "" ]]; then
    docker rmi $TEST_IMAGE_NAME
fi
# . 是查找本地所有的文件
docker build --tag=$TEST_IMAGE_NAME .

# docker run  --rm -it --name $TEST_CONTAINER_NAME   $TEST_IMAGE_NAME

docker run  --rm -it --name $TEST_CONTAINER_NAME -v $MONGODB_DIR:/data/db -p 27018:27017 $TEST_IMAGE_NAME
