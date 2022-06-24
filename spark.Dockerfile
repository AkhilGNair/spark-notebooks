FROM phusion/baseimage:focal-1.2.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl openjdk-8-jre && \
    apt-get autoremove -y && \
    apt-get clean

# Prepare environment
ENV SCALA_VERSION      2.12
ENV SPARK_HOME         /opt/apache-spark
ENV SPARK_VERSION      3.2.1
ENV DELTA_LAKE_VERSION 1.2.1
ENV PATH               $SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH
ENV SPARK_URL          https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz
ENV DELTA_LAKE_URL     https://repo1.maven.org/maven2/io/delta/delta-core_${SCALA_VERSION}/${DELTA_LAKE_VERSION}/delta-core_${SCALA_VERSION}-${DELTA_LAKE_VERSION}.jar
ENV DELTA_STORAGE_URL  https://repo1.maven.org/maven2/io/delta/delta-storage/${DELTA_LAKE_VERSION}/delta-storage-${DELTA_LAKE_VERSION}.jar

# Download pre-compiled Apache Spark
RUN wget $SPARK_URL -O /tmp/spark-bin.tgz && \
    tar -xzf /tmp/spark-bin.tgz -C /opt && \
    mv "/opt/spark-${SPARK_VERSION}-bin-hadoop2.7" $SPARK_HOME && \
    rm -f /tmp/spark-bin.tgz && \
    wget -q ${DELTA_LAKE_URL} \
    -O ${SPARK_HOME}/jars/delta-core_${SCALA_VERSION}-${DELTA_LAKE_VERSION}.jar && \
    wget -q ${DELTA_STORAGE_URL} \
    -O ${SPARK_HOME}/jars/delta-storage-${DELTA_LAKE_VERSION}.jar

# Ports for Web-UI and Spark-Master
EXPOSE 8080 8081 7077 6066 4040

# Default mode: Execute Spark Shell
CMD ["spark-shell", "--master", "local[2]"]
