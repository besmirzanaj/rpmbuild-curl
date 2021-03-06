FROM rpmbuild:6-build

USER root
RUN yum -y install \
        gnutls-utils \
        libidn2-devel \
        libnghttp2-devel \
        nghttp2 \
        openssl-devel \
        perl-Time-HiRes \
        stunnel \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "curl.spec"]
CMD ["-ba"]