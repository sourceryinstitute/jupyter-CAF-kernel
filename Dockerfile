FROM sourceryinstitute/jupyter-caf-kernel@sha256:38dd912cb6b77ada570c2cb68d65eddf61ddf921212f1f1cb61c5f6c9f48e2e7

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
