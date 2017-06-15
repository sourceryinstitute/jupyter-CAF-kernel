FROM sourceryinstitute/jupyter-caf-kernel@sha256:c54048c6604dc8c5b8d4b6ec6323079809bf6c4451ce65ebc95c6f4ce2d05153

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

COPY index.ipynb ./

USER $NB_USER
