

FROM blacklabelops/centos:7
LABEL maintainer "Mangesh Bhalerao <mangesh {{at}} devopxy {{dot}} com "

## core dependencies
RUN yum install -y make automake cmake gcc gcc-c++ gcc-gfortran blas-devel cmake lapack-devel bison flex fftw-devel suitesparse-devel epel-release

## Paralel version

RUN yum install -y openmpi-devel metis-devel metis64-devel

ENV PATH=$PATH:/usr/lib64/openmpi/bin/
ENV XYCE_SRCDIR=/opt/Xyce/
ENV XYCE_OUTDIR=/usr/local/
WORKDIR $XYCE_SRCDIR

## Builds parmetis : latest version
ENV PARMETIS_VERSION=4.0.3
RUN curl http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-${PARMETIS_VERSION}.tar.gz | gunzip | tar x && cd parmetis-${PARMETIS_VERSION} && \
make config prefix=$XYCE_OUTDIR && make && make install && cd ../ && rm -rf parmetis*

## Builds Trilinos : latest version
ENV TRILINOS_VERSION=12.12.1
COPY ./trilinos-reconfigure-parallel.sh ./trilinos-reconfigure.sh
RUN mkdir Trilinos && cd Trilinos && curl -L https://github.com/trilinos/Trilinos/archive/trilinos-release-${TRILINOS_VERSION//./-}.tar.gz | \
tar xz && mv Trilinos-trilinos-release-${TRILINOS_VERSION//./-} trilinos-source && ../trilinos-reconfigure.sh && make && make install && cd ../ && rm -rf Trilinos* && rm trilinos-reconfigure.sh

