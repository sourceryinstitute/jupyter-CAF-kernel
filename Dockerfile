FROM sourceryinstitute/jupyter-caf-kernel:latest

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

# Try to trigger a rebuild on beta.mybinder.org

COPY index.ipynb ./

USER $NB_USER
