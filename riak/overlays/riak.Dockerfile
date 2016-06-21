
# Install Riak
RUN curl -sSL https://packagecloud.io/basho/riak-ts/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/basho/riak-ts/ubuntu/ trusty main" >/etc/apt/sources.list.d/basho_riak-ts.list
RUN echo "deb-src https://packagecloud.io/basho/riak-ts/ubuntu/ trusty main" >>/etc/apt/sources.list.d/basho_riak-ts.list
RUN apt-get update
RUN apt-get install -y riak-ts
RUN curl -sSL https://basholabs.artifactoryonline.com/basholabs/riak-mesos-framework/ubuntu-14.04/riak-explorer/1.1.0/riak_explorer-1.1.0.patch-ubuntu-14.04.tar.gz | tar -zxf - -C /usr/lib/riak --strip-components 2

VOLUME /var/log/riak
VOLUME /var/lib/riak

COPY $CURDIR/riak-cluster.sh /usr/lib/riak/riak-cluster.sh
RUN chmod a+x /usr/lib/riak/riak-cluster.sh

# Install the Python client
RUN \
  cd /usr/lib/python2.7/dist-packages && \
  curl -sSLO https://pypi.python.org/packages/2.7/r/riak/riak-2.4.2-py2.7.egg && \
  curl -sSLO https://pypi.python.org/packages/2.7/p/protobuf/protobuf-2.6.1-py2.7.egg && \
  unzip -o riak-2.4.2-py2.7.egg && \
  unzip -o protobuf-2.6.1-py2.7.egg

EXPOSE 8087
EXPOSE 8098

WORKDIR /var/lib/riak
CMD ["/usr/lib/riak/riak-cluster.sh"]
