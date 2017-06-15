FROM sourceryinstitute/jupyter-caf-kernel@sha256:b0ca76e393dd57cb1e10a48e3cc0d4043ebaf1319f556f1d40137048b83554a3

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
