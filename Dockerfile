FROM sourceryinstitute/jupyter-caf-kernel:2d5967e2c6d3

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ${HOME}
# COPY examples ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
