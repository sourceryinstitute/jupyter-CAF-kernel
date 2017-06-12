FROM sourceryinstitute/jupyter-caf-kernel:latest

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
