FROM jiata/aztk:0.1.0-spark2.2.0-python3.5.4
FROM rocker/rstudio-stable:latest

## Install external dependencies for R and packages
ENV DEBIAN_FRONTEND noninteractive

# RUN apt-get update \
#   && apt-get install -y --no-install-recommends \
#     r-base \
#     libcurl4-openssl-dev \
#     libxml2-dev \
#     libapparmor1 \
#     gdebi-core \
#     locales \
#     vim
## Install R Client

# RUN apt-get update -qq \
#     && apt-get dist-upgrade -y \
#     && apt-get install -y wget make gcc \
#     && apt-get install apt-transport-https -y \
#     && wget http://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
#     && dpkg -i packages-microsoft-prod.deb \
#     && apt-get update \
#     && apt-get install microsoft-r-client-packages-3.4.1 -y \
#     && apt-get install microsoft-r-client-mml-3.4.1 -y \
#     && apt-get install microsoft-r-client-mlm-3.4.1 -y \
#     && rm *.deb

## Install Packages

# RUN Rscript -e "install.packages(c('littler', 'docopt'), repo = 'cran.rstudio.com')" \
#   && ln -s /usr/local/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
#   && ln -s /usr/local/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
#   && ln -s /usr/local/lib/R/site-library/littler/bin/r /usr/local/bin/r \
#   ## TEMPORARY WORKAROUND to get more robust error handling for install2.r prior to littler update
#   && curl -O /usr/local/bin/install2.r https://github.com/eddelbuettel/littler/raw/master/inst/examples/install2.r \
#   && chmod +x /usr/local/bin/install2.r \
#   ## Clean up from R source install
#   && cd / \
#   && rm -rf /tmp/* \
#   && apt-get remove --purge -y $BUILDDEPS \
#   && apt-get autoremove -y \
#   && apt-get autoclean -y \
#   && install2.r -e -r tidyverse sparklyr

## Install rstudio-server
# RUN wget https://raw.githubusercontent.com/akzaidi/etc/master/inst/install-rstudio-ubuntu.sh
# RUN chmod +x ./install-rstudio-ubuntu.sh && bash ./install-rstudio-ubuntu.sh 1.2.104
# RUN rm ./install-rstudio-ubuntu.sh 

