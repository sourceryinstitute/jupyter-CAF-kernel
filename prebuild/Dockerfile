FROM jupyter/datascience-notebook:5ded1de07260

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ARG OPENCOARRAYS_VERSION=1.9.1
ENV GCC_VERSION 7.1.0

ENV NUM_IMAGES 4

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
    gcc-7 \
    gfortran-7 \
    ${transientBuildDeps} \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-7 \
    && update-alternatives --set gcc "/usr/bin/gcc-7" \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Patching build script for MPICH to disable c++ bindings" \
    && sed -i '/configure --prefix=/ s/configure --prefix/configure --disable-cxx --prefix/' prerequisites/build-functions/build_and_install.sh \
    && gcc --version \
    && gfortran --version \
    && ./install.sh --yes-to-all --package mpich -j "$(nproc)" --install-prefix /usr/local \
    && cd .. \
    && mpiexec --version \
    && rm -rf OpenCoarrays-${OPENCOARRAYS_VERSION}/ \
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

ARG RUN_TESTS=true

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="cmake git" \
    && set -v \
    && echo "${DEBIAN_FRONTEND}" \
    && apt-get update && apt-get install -y \
    ${transientBuildDeps} \
    && cmake --version \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Installing OpenCoarrays using CMake in $(pwd)" \
    && mkdir build \
    && cd build \
    && gcc --version \
    && gfortran --version \
    && FC="`which gfortran`" CC="`which gcc`" cmake .. \
    && make -j "$(nproc)" \
    && if [ "${RUN_TESTS}" == "true" ] ; then ctest --output-on-failure; fi \
    && make install \
    && cd \
    && rm -rf OpenCoarrays* opencoarrays* \
    && caf --version \
    && pip install -e /jupyter/jupyter-caf-kernel \
    && jupyter-kernelspec install /jupyter/jupyter-caf-kernel/Coarray-Fortran/ \
    && jupyter-kernelspec list \
    && pip install allthekernels \
    && pip install mpld3 \
    && pip install JSAnimation \
    && pip install ipywidgets \
    && pip install bokeh \
    && jupyter nbextension install https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/gist.js \
    && jupyter nbextension enable gist \
    && jupyter nbextension install --user https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.js \
    && curl -L https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.css > $(jupyter --data-dir)/nbextensions/toc.css \
    && jupyter nbextension enable toc \
    && rm -rf jupyter-caf-kernel \
    && apt-get clean \
    && apt-get purge -y --auto-remove ${transientBuildDeps} \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# RUN mkdir /jupyter

# WORKDIR /jupyter

RUN chown -R ${NB_USER}:users /home/${NB_USER}

WORKDIR /home/${NB_USER}/

USER ${NB_USER}
