FROM sourceryinstitute/jupyter-caf-kernel@sha256:82b20bf27faa40887c6e0e6043768e4324a87701ae7f71b80688382713053c29

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./
# COPY examples ./

USER $NB_USER
