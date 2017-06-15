FROM sourceryinstitute/jupyter-caf-kernel@sha256:4bb286f18842d93c3d0d14459602ae9daca9c2f8bd86c4f4bf969ac6fa1b5467

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
