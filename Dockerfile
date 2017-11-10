FROM sourceryinstitute/jupyter-caf-kernel:120b01234461

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ${HOME}
# COPY examples ${HOME}
