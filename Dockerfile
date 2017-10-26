FROM jiata/aztk-vanilla:0.1.0-spark2.2.0

## Install external dependencies for R and packages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends  \
    r-base \
    libcurl4-openssl-dev \
    libxml2-dev \
    libapparmor1 \
    gdebi-core \
    gfortran \
  && . /etc/environment \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install Packages
RUN Rscript -e "install.packages(c('littler', 'docopt', 'tidyverse', 'sparklyr'), repo = 'http://cran.us.r-project.org')" \
  && echo 'Sys.setenv(SPARK_HOME = $SPARK_HOME)' >> /etc/R/Rprofile.site

## Install rstudio-server
RUN wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
RUN gdebi rstudio-server-1.1.383-amd64.deb --non-interactive
RUN echo "server-app-armor-enabled=0" | tee -a /etc/rstudio/rserver.conf

## Create user for rstudio-server
RUN set -e \
  && useradd -m -d /home/rstudio rstudio \
  && echo rstudio:rstudio | chpasswd

EXPOSE 8787