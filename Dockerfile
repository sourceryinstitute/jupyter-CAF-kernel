FROM sourceryinstitute/jupyter-caf-kernel:a7c4b3a9a3e2

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ${HOME}
# COPY examples ${HOME}
