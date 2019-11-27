#!/bin/bash
#push google or coreos images to dockerhub or aliyun registry,
#change the registry name and username/password to yourself's.

DOCKER_HUB=pigporket

#config the following env at travis-ui
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker login registry.cn-beijing.aliyuncs.com -u $ALI_USERNAME  -p $ALI_PASSWORD

for image in $(cat img-list.txt)
do
	imagename=$(echo $image | awk -F '/' '{print $NF}')
	docker pull $image
	docker tag $image registry.cn-beijing.aliyuncs.com/alisop23/$imagename
	docker tag $image $DOCKER_HUB/$imagename
	# push到dockerhub
	docker push $DOCKER_HUB/$imagename
	# push到阿里云仓库
	docker push registry.cn-beijing.aliyuncs.com/alisop23/$imagename
done
