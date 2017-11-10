FROM sourceryinstitute/jupyter-caf-kernel@sha256:141576175bf5b9aebad852496760e2e9c839423dfd9e100722b1031b61359811

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ${HOME}
# COPY examples ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
