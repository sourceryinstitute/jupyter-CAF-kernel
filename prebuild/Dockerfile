FROM jupyter/datascience-notebook

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ARG OPENCOARRAYS_VERSION=1.9.0
ENV GCC_VERSION 7.1.0

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="dpkg-dev flex" \
    && set -v \
    && echo "${DEBIAN_FRONTEND}" \
    && echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get -t jessie-backports install -yq --no-install-recommends --no-install-suggests \
    make \
    libfile-pushd-perl \
    libisl-dev \
    libmpc-dev \
    ${transientBuildDeps} \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget -nv -t 3 https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Patching build script for MPICH to disable c++ bindings" \
    && sed -i '33 s/configure --prefix/configure --disable-cxx --prefix/' prerequisites/build-functions/build_and_install.sh \
    && ./install.sh --only-download --package gcc --install-version ${GCC_VERSION} \
    && cd prerequisites/downloads/ \
    && tar xf gcc-${GCC_VERSION}.tar* \
    && cd gcc-${GCC_VERSION} \
    && mkdir objdir \
    && cd objdir \
    && ../configure --enable-languages=c,fortran --disable-multilib --disable-bootstrap --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && make -j"$(nproc)" \
    && make -j"$(nproc)" install-strip \
    && cd ../.. \
    && rm -rf ./gcc* \
    && echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf \
    && ldconfig -v\
    && dpkg-divert --divert /usr/bin/gcc.orig --rename /usr/bin/gcc \
    && dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/bin/gfortran \
    && update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 999 \
    && /usr/local/bin/gcc --version \
    && gcc --version \
    && /usr/local/bin/gfortran --version \
    && gfortran --version \
    && cd ../.. \
    && ./install.sh --yes-to-all --package mpich -j "$(nproc)" --install-prefix /usr/local \
    && cd .. \
    && mpirun --version \
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

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="cmake" \
    && set -v \
    && echo "${DEBIAN_FRONTEND}" \
    && apt-get update && apt-get -t jessie-backports install -yq --no-install-recommends --no-install-suggests \
    ${transientBuildDeps} \
    && cmake --version \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Installing OpenCoarrays using CMake in $(pwd)" \
    && mkdir build \
    && cd build \
    && FC=/usr/local/bin/gfortran CC=/usr/local/bin/gcc cmake .. \
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
    && rmdir work \
    && rm -rf jupyter-caf-kernel \
    && apt-get clean \
    && apt-get purge -y --auto-remove ${transientBuildDeps} \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# RUN mkdir /jupyter

# WORKDIR /jupyter

RUN chown -R ${NB_USER}:users /home/${NB_USER}

WORKDIR /home/${NB_USER}/

USER ${NB_USER}
