FROM jupyter/datascience-notebook

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ARG OPENCOARRAYS_VERSION=1.9.0
#ENV MPICH_VERSION 3.2
ENV GCC_VERSION 7.1.0

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="apt-utils bison dpkg-dev flex libfile-pushd-perl" \
    && set -v \
    && echo "$DEBIAN_FRONTEND" \
    && echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get -t jessie-backports upgrade -yq --no-install-recommends --no-install-suggests \
    && apt-get -t jessie-backports install -yq --no-install-recommends --no-install-suggests \
    file \
    g++ \
    gcc \
    gfortran \
    make \
    libisl-dev \
    libmpc-dev \
    libtool \
    $transientBuildDeps \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzvf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && ./install.sh --only-download --package gcc --install-version ${GCC_VERSION} \
    && cd prerequisites/downloads/ \
    && tar xf gcc-${GCC_VERSION}.tar* \
    && cd gcc-${GCC_VERSION} \
    && mkdir objdir \
    && cd objdir \
    && ../configure --enable-languages=c,c++,fortran --disable-multilib --disable-bootstrap --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && make -j"$(nproc)" \
    && make install-strip \
    && make distclean \
    && cd ../.. \
    && rm -rf ./gcc* \
    && echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf \
    && ldconfig -v\
    && dpkg-divert --divert /usr/bin/gcc.orig --rename /usr/bin/gcc \
    && dpkg-divert --divert /usr/bin/g++.orig --rename /usr/bin/g++ \
    && dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/bin/gfortran \
    && update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 999 \
    && /usr/local/bin/gcc --version \
    && gcc --version \
    && /usr/local/bin/gfortran --version \
    && gfortran --version \
    && cd ../../ \
    && ./install.sh --yes-to-all --package mpich -j "$(nproc)" -c /usr/local/bin/gcc -f /usr/local/bin/gfortran -C /usr/local/bin/g++ --install-prefix /usr/local \
    && cd \
    && mpirun --version \
    && mpifort --version \
    && rm -rf OpenCoarrays* opencoarrays* \
    && apt-get clean \
    && apt-get purge -y --auto-remove $transientBuildDeps \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# Build-time metadata as defined at http://label-schema.org
    ARG BUILD_DATE
    ARG VCS_REF
    ARG VCS_URL
    ARG VCS_VERSION=latest
    LABEL org.label-schema.schema-version="1.0" \
          org.label-schema.build-date="$BUILD_DATE" \
          org.label-schema.name="jupyter-CAF-kernel" \
          org.label-schema.description="Fortran Jupyter kernel with OpenCoarrays and MPICH backend" \
          org.label-schema.url="https://github.com/sourceryinstitute/jupyter-CAF-kernel/" \
          org.label-schema.vcs-ref="$VCS_REF" \
          org.label-schema.vcs-url="$VCS_URL" \
          org.label-schema.version="$VCS_VERSION" \
          org.label-schema.vendor="SourceryInstitute" \
          org.label-schema.license="MIT" \
          org.label-schema.docker.cmd="docker run -i -t -p 8888:8888 sourceryinstitute/jupyter-CAF-kernel"

COPY ./jupyter-caf-kernel jupyter-caf-kernel

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="apt-utils cmake dpkg-dev libfile-pushd-perl" \
    && set -v \
    && echo "$DEBIAN_FRONTEND" \
    && apt-get update && apt-get -t jessie-backports install -yq --no-install-recommends --no-install-suggests \
    $transientBuildDeps \
    && cmake --version \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzvf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && echo "Installing OpenCoarrays using CMake in $(pwd)" \
    && mkdir build \
    && cd build \
    && FC=/usr/local/bin/gfortran CC=/usr/local/bin/gcc cmake .. \
    && make -j "$(nproc)" \
    && ctest --output-on-failure \
    && make install \
    && cd \
    && rm -rf OpenCoarrays* opencoarrays* \
    && caf --version \
    && pip install -e ./jupyter-caf-kernel \
    && jupyter-kernelspec install ./jupyter-caf-kernel/Coarray-Fortran/ \
    && jupyter-kernelspec list \
    && apt-get clean \
    && apt-get purge -y --auto-remove $transientBuildDeps \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# RUN mkdir /jupyter

# WORKDIR /jupyter

# COPY ./ jupyter_c_kernel/
# RUN pip install -e jupyter_c_kernel/

# RUN jupyter-kernelspec install jupyter_c_kernel/c_spec/

# WORKDIR /home/$NB_USER/

RUN chown -R $NB_USER:users /home/$NB_USER

USER $NB_USER
