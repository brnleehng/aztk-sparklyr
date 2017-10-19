FROM jiata/aztk:0.1.0-spark2.2.0-python3.5.4

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

## Install R Client

RUN apt-get update -qq \
    && apt-get dist-upgrade -y \
    && apt-get install -y wget make gcc \
    && apt-get install apt-transport-https -y \
    && wget http://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install microsoft-r-client-packages-3.4.1 -y \
    && apt-get install microsoft-r-client-mml-3.4.1 -y \
    && apt-get install microsoft-r-client-mlm-3.4.1 -y \
    && rm *.deb

## Install Packages
RUN mlserver-Rscript-bin -e "install.packages(c('littler', 'docopt', 'tidyverse', 'sparklyr'), repo = 'http://cran.us.r-project.org')"

## Install rstudio-server
RUN wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
RUN gdebi rstudio-server-1.1.383-amd64.deb --non-interactive
RUN echo "server-app-armor-enabled=0" | tee -a /etc/rstudio/rserver.conf

# Create user
RUN set -e \
      && useradd -m -d /home/rstudio rstudio \
      && echo rstudio:rstudio \
        | chpasswd

# Set R to R Client

# set rclient to rsession for rstudio-server
RUN echo "rsession-which-r=/opt/microsoft/rclient/3.4.1/bin/R/R" >> /etc/rstudio/rserver.conf
RUN echo "r-libs-user=/opt/microsoft/rclient/3.4.1/libraries/RServer" >> /etc/rstudio/rsession.conf

# start rstudio-server session
EXPOSE 8787

CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--server-app-armor-enabled=0"]

