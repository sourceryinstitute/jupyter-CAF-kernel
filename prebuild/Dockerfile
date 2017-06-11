FROM jupyter/base-notebook

MAINTAINER Izaak Beekman <izaak@izaakbeekman.com>

USER root

ARG OPENCOARRAYS_VERSION=1.9.0

RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="apt-utils bison cmake dpkg-dev flex gcc gfortran g++ libfile-pushd-perl" \
    && set -v \
    && echo "$DEBIAN_FRONTEND" \
    && echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update && apt-get -t jessie-backports install -yq --no-install-recommends --no-install-suggests \
    build-essential \
    elfutils \
    file \
    libisl-dev \
    libmpc-dev \
    libtool \
    $transientBuildDeps \
    && cmake --version \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && wget https://github.com/sourceryinstitute/opencoarrays/releases/download/${OPENCOARRAYS_VERSION}/opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && sha256sum -c opencoarrays-${OPENCOARRAYS_VERSION}-SHA256.txt \
    && tar xzvf OpenCoarrays-${OPENCOARRAYS_VERSION}.tar.gz \
    && cd OpenCoarrays-${OPENCOARRAYS_VERSION} \
    && ./install.sh --only-download --package gcc --install-version 7.1.0 \
    && cd prerequisites/downloads/ \
    && tar xf gcc-7.1.0.tar* \
    && cd gcc-7.1.0 \
    && mkdir objdir \
    && cd objdir \
    && ../configure --enable-languages=c,c++,fortran --disable-multilib --disable-bootstrap --build=x86_64-linux-gnu \
    && make -j"$(nproc)" \
    && make install-strip \
    && make distclean \
    && cd ../.. \
    && rm -rf ./gcc* \
    && /usr/local/bin/gcc --version \
    && gcc --version \
    && echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf \
    && ldconfig -v\
    && dpkg-divert --divert /usr/bin/gcc.orig --rename /usr/bin/gcc \
    && dpkg-divert --divert /usr/bin/g++.orig --rename /usr/bin/g++ \
    && dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/bin/gfortran \
    && update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 999 \
    && cd ../.. \
    && ./install.sh --yes-to-all --package mpich -j "$(nproc)" -c /usr/local/bin/gcc -f /usr/local/bin/gfortran -C /usr/local/bin/g++ --install-prefix /usr/local \
    && rm -rf ./prerequisites/{builds,downloads}/* \
    && echo "Installing OpenCoarrays using CMake in $(pwd)" \
    && mkdir build \
    && cd build \
    && FC=/usr/local/bin/gfortran CC=/usr/local/bin/gcc cmake .. \
    && make -j "$(nproc)" \
    && ctest --output-on-failure \
    && make install \
    && cd .. \
    && rm -rf build \
    && caf --version \
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
