FROM sourceryinstitute/jupyter-caf-kernel@sha256:78145220a417eb1412611f52b6f908c05531f30997b46e85a5a3b3092704c0e9

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

# Try to trigger a rebuild on beta.mybinder.org

COPY index.ipynb ./

USER $NB_USER
