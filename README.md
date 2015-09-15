# A Simple `spring-boot` app using Docker :whale:
This project contains a simple `docker-compose.yml` that should help make building and running your spring-boot application easy.  There are no Docker maven plugins required in this example.  

## Try it out
```shell
$ docker-compose up
```

## How do I build an image for release?
To create a new `tombee/spring-boot-sample:latest` image, run:
```
$ make
```

To create `tombee/spring-boot-sample:1.0`, run:
```
$ IMAGE_TAG=1.0 make
```

## How does the `Makefile` work?  

### Step 1. Building the executable jar
```
$ make package-jar
```

The build itself runs in a `maven:3.3.3-jdk-8` container, you'll see your familiar `target/` directory appear after running the build.  See the `package-jar` rule in the `Makefile` for more information.  It works by mounting the current directory as a volume inside the container.  The container provides the specific JDK and Maven installation that is required -- meaning no more managing multiple JDK and Maven versions! :)

As a performance tweak, the `.m2` directory is mounted as a volume too, into the maven directory.  This way the `.m2` directory is re-used for each build -- you might need to tweak how this works to suit your build infrastructure.

### Step 2. Building the docker image
```
$ make build
```

This is pretty straightforward, once we've build the executable jar using our `maven:3.3.3-jdk-8` container, all we need to do now is create a new image from the `java:8` base image, `ADD`ing our executable jar, `EXPOSE`d port definitions and our `CMD` to start it up.

