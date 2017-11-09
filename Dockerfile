FROM sourceryinstitute/jupyter-caf-kernel@sha256:cf2aa6b479657b043d85f8c451a4862a2849367c561ffd1de6ddce3a91009aa3

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ${HOME}
# COPY examples ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
