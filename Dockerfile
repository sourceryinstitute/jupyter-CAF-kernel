FROM sourceryinstitute/jupyter-caf-kernel@sha256:0f54eba61ab719c463ea524087554b25092864f4385a29cdb268db68e8103ec5

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
