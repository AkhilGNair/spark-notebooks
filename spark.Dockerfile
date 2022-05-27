FROM phusion/baseimage:focal-1.2.0

ENV URL https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl openjdk-8-jre && \
    apt-get autoremove -y && \
    apt-get clean

# Prepare environment
ENV SPARK_HOME /opt/apache-spark 
ENV PATH       $SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH

# Download pre-compiled Apache Spark
RUN wget $URL -O /tmp/spark-bin.tgz && \
    tar -xzf /tmp/spark-bin.tgz -C /opt && \
    mv /opt/spark-2.4.0-bin-hadoop2.7 $SPARK_HOME && \
    rm -f /tmp/spark-bin.tgz

# Ports for Web-UI and Spark-Master
EXPOSE 8080 8081 7077 6066 4040

# Default mode: Execute Spark Shell
CMD ["spark-shell", "--master", "local[2]"]
