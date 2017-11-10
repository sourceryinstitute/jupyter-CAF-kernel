FROM jupyter/minimal-notebook:da2c5a4d00fa

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ARG OPENCOARRAYS_VERSION=1.9.2
ENV GCC_VERSION 7.2.0

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="file" \
    && set -v \
    && cat /etc/issue \
    && uname -a \
    && echo "${DEBIAN_FRONTEND}" \
    && apt-get update -y \
    && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
    && apt-get update -y \
    && apt-get install -y \
    build-essential \
    gcc-7=${GCC_VERSION}-1ubuntu1~16.04 \
    gfortran-7=${GCC_VERSION}-1ubuntu1~16.04 \
    g++-7=${GCC_VERSION}-1ubuntu1~16.04 \
    mpich \
    ${transientBuildDeps} \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-7 \
    && update-alternatives --set gcc "/usr/bin/gcc-7" \
    && gcc --version \
    && gfortran --version \
    && mpiexec --version \
    && mpifort --version \
    && mpicc --version \
    && apt-get clean \
    && apt-get purge -y --auto-remove ${transientBuildDeps} \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# Build-time metadata as defined at http://label-schema.org
    ARG BUILD_DATE
    ARG VCS_REF
    ARG VCS_URL
    ARG VCS_VERSION=latest
    LABEL org.label-schema.schema-version="1.0" \
          org.label-schema.build-date="${BUILD_DATE}" \
          org.label-schema.name="jupyter-CAF-kernel" \
          org.label-schema.description="Fortran Jupyter kernel with OpenCoarrays and MPICH backend" \
          org.label-schema.url="https://github.com/sourceryinstitute/jupyter-CAF-kernel/" \
          org.label-schema.vcs-ref="${VCS_REF}" \
          org.label-schema.vcs-url="${VCS_URL}" \
          org.label-schema.version="${VCS_VERSION}" \
          org.label-schema.vendor="SourceryInstitute" \
          org.label-schema.license="MIT" \
          org.label-schema.docker.cmd="docker run -i -t -p 8888:8888 sourceryinstitute/jupyter-CAF-kernel"

COPY ./jupyter-caf-kernel /jupyter/jupyter-caf-kernel

ARG RUN_TESTS=false
ARG RUN_AS_NB_USER="sudo -H -u ${NB_USER} bash -c"

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="cmake git" \
    && set -v \
    && echo "${DEBIAN_FRONTEND}" \
    &&  adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} || true \
    && apt-get update && apt-get install -y \
    ${transientBuildDeps} \
    && cmake --version \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Installing OpenCoarrays using CMake in $(pwd)" \
    && mkdir build \
    && cd build \
    && gcc --version \
    && gfortran --version \
    && FC="`which gfortran`" CC="`which gcc`" cmake .. \
    && make -j "$(nproc)" install \
    && if [ "${RUN_TESTS}" = "true" ] ; then ctest --output-on-failure; fi \
    && cd \
    && rm -rf OpenCoarrays* opencoarrays* \
    && caf --version \
    && ${RUN_AS_NB_USER} 'pip install --no-cache-dir notebook==5.*' \
    && ${RUN_AS_NB_USER} 'pip install -e /jupyter/jupyter-caf-kernel' \
    && ${RUN_AS_NB_USER} 'jupyter-kernelspec install /jupyter/jupyter-caf-kernel/Coarray-Fortran/' \
    && ${RUN_AS_NB_USER} 'jupyter-kernelspec list' \
    && ${RUN_AS_NB_USER} 'pip install --no-cache-dir allthekernels' \
    && ${RUN_AS_NB_USER} 'pip install --no-cache-dir mpld3' \
    && ${RUN_AS_NB_USER} 'pip install --no-cache-dir JSAnimation' \
    && ${RUN_AS_NB_USER} 'pip install --no-cache-dir ipywidgets' \
    && ${RUN_AS_NB_USER} 'jupyter nbextension install https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/gist.js' \
    && ${RUN_AS_NB_USER} 'jupyter nbextension enable gist' \
    && ${RUN_AS_NB_USER} 'jupyter nbextension install --user https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.js' \
    && ${RUN_AS_NB_USER} 'wget -qO- https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.css > $(jupyter --data-dir)/nbextensions/toc.css' \
    && ${RUN_AS_NB_USER} 'jupyter nbextension enable toc' \
    && rm -rf jupyter-caf-kernel \
    && apt-get clean \
    && apt-get purge -y --auto-remove ${transientBuildDeps} \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/* \
    && chown -R ${NB_USER} /home/${NB_USER}

WORKDIR /home/${NB_USER}/

ENV NUM_IMAGES 4

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

USER ${NB_USER}
