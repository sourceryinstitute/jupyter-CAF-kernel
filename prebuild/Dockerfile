FROM jupyter/minimal-notebook:4cdbc9cdb7d1

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

ARG OPENCOARRAYS_VERSION=2.6.2
ENV GCC_VERSION 8.2.0

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
    gcc-8 \
    gfortran-8 \
    g++-8 \
    mpich \
    ${transientBuildDeps} \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-8 \
    && update-alternatives --set gcc "/usr/bin/gcc-8" \
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
    && pip install --no-cache-dir notebook==5.* \
    && pip install -e /jupyter/jupyter-caf-kernel \
    && jupyter-kernelspec install /jupyter/jupyter-caf-kernel/Coarray-Fortran/ \
    && jupyter-kernelspec list \
    && rm -rf jupyter-caf-kernel \
    && apt-get clean \
    && apt-get purge -y --auto-remove ${transientBuildDeps} \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/* \
    && chown -R ${NB_USER} /home/${NB_USER}

WORKDIR /home/${NB_USER}/

ENV NUM_IMAGES 4

USER ${NB_USER}
