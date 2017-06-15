FROM sourceryinstitute/jupyter-caf-kernel@sha256:ff92d0a4da10f264eafba63730575f6dd89de539273a3a4de85f9e9dd9620720

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
