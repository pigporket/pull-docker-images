#!/bin/bash
#push google or coreos images to dockerhub or aliyun registry,
#change the registry name and username/password to yourself's.

DOCKER_HUB=pigporket
ALI_REGISTRY=registry.cn-beijing.aliyuncs.com/alisop23

#config the following env at travis-ui
#docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker login registry.cn-beijing.aliyuncs.com -u $ALI_USERNAME  -p $ALI_PASSWORD

for image in $(cat img-list.txt)
do
	#imagename=$(echo $image | awk -F '/' '{print $NF}')
	imagename=$(echo $image | awk -F '/' '{print $2"-"$3}')
	docker pull $image
	docker tag $image $ALI_REGISTRY/$imagename
	#docker tag $image $DOCKER_HUB/$imagename
	# push到dockerhub
	#docker push $DOCKER_HUB/$imagename
	# push到阿里云仓库
	docker push $ALI_REGISTRY/$imagename
done
