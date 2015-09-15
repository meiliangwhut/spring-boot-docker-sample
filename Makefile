.PHONY: all build package-jar run

IMAGE_NAME=tombee/spring-boot-sample
IMAGE_TAG=latest

MAVEN_TAG=3.3.3-jdk-8

all: package-jar build

package-jar:
	@docker run --volume `pwd`/gs-spring-boot-docker:/build \
				--volume `pwd`/.m2:/root/.m2 \
				--workdir /build \
				maven:$(MAVEN_TAG) \
				mvn package

build:
	@docker build -t ${IMAGE_NAME}:${IMAGE_TAG} gs-spring-boot-docker 

