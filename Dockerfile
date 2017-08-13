FROM sourceryinstitute/jupyter-caf-kernel@sha256:dfe94467325df55a7b83a2bea41b2b40f832229ca5ca92757e49aa866f5f62d8

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./
COPY examples ./

USER $NB_USER
