#!/usr/bin/env bash

set -x

export SPARK_MASTER=spark://master-node:7077      # Spark master url. eg. spark://master_addr:7077. Leave empty if you want to use local mode.
export ZEPPELIN_ADDR=0.0.0.0                          # Bind address (default 127.0.0.1)
export ZEPPELIN_PORT=8888                       # port number to listen (default 8080)

/opt/zeppelin-0.10.1-bin-all/bin/zeppelin-daemon.sh start
tail -f /opt/zeppelin-0.10.1-bin-all/logs/zeppelin--*log
