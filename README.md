# R
This Dockerfile is used to build the __aztk-r__ Docker image used by this toolkit. This image uses Anaconda, providing access to a wide range of popular python packages.

You can modify these Dockerfiles to build your own image. However, in mose cases, building on top of the __aztk-vanilla__ image is recommended.

## How to build this image
This Dockerfile takes in a variable at build time that allow you to specify your desired Rstudio server versions: **RSTUDIO_SERVER_VERSION** 

By default, we set **RSTUDIO_SERVER_VERSION=1.1.383**.

For example, if I wanted to use Rstudio Server v1.1.383 with Spark v2.1.0, I would select the appropriate Dockerfile and build the image as follows:
```sh
# spark2.1.0/Dockerfile
docker build \
    --build-arg RSTUDIO_SERVER_VERSION=1.1.383 \
    -t <my_image_tag> .
```

**RSTUDIO_SERVER_VERSION** is used to set the version of rstudio server for your cluster. 