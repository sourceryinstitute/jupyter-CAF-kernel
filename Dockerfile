FROM sourceryinstitute/jupyter-caf-kernel@sha256:9820b4049897758216c1c60dc29d6d6773516ea2c0ed784b1a738ab368c7668d

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
