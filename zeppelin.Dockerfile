FROM spark:3.2.1

# Set some environment variables
ENV DOWNLOAD_URL https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz
ENV ZEPPELIN_HOME /opt/apache-zeppelin
ENV PATH          $ZEPPELIN_HOME/bin:$PATH

RUN curl -L -O $DOWNLOAD_URL && \
    tar -xzf zeppelin-0.10.1-bin-all.tgz -C /opt && \
    ln -s /opt/zeppelin-0.10.1-bin-all $ZEPPELIN_HOME && \
    rm -fr zeppelin-0.10.1-bin-all.tgz

COPY startup.sh /usr/bin/startup.sh
RUN chmod 755 /usr/bin/startup.sh

# # Default ports for Zeppelin UI and websocket connection
# ENV ZEPPELIN_ADDR 127.0.0.1  # Bind address (default 127.0.0.1)
# ENV ZEPPELIN_PORT 8080     # port number to listen (default 8080)

EXPOSE 8888 8889 8080 8081

# Default mode: Execute Zeppelin Daemon
CMD ["startup.sh"]
