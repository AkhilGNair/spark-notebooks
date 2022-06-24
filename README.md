# Spark Notebooks

This repo allows the user to launch a Zeppelin notebook attached to a spark cluster.

This is very much for development and experiment purposes only.
For example, the data folder is mounted to all the workers so that the data is accessible
without having to use network storage.

Credits to the [original author](https://github.com/tssp/docker-zeppelin) of the docker setup.

## Usage

`docker-compose` is used to launch the services. 

To launch

 - Make sure you have `docker` installed
 - Create and launch a virtual environment
 - Run `pip install docker-compose` 
   - Only necessary if you are using a version of docker that does not ship with `compose`
 - Move into this directory and run `docker-compose up -d`

The Zeppelin notebook server will available at `localhost:8888`.
You can create a new notebook and immediately start using spark :sparkles:.

To kill the services when you are done, you can run

```
docker-compose down
```

from this directory.

## Delta Lake

To confirm that the `delta` file format is installed and available,
first configure the spark context

```
%spark.conf

spark.jars.packages io.delta:delta-core_2.12:1.2.1
spark.jars.packages io.delta:delta-storage:1.2.1
spark.sql.extensions io.delta.sql.DeltaSparkSessionExtension
spark.sql.catalog.spark_catalog org.apache.spark.sql.delta.catalog.DeltaCatalog
spark.sql.warehouse.dir /root/data/warehouse
```

Then, write some example data to a `delta` table

```
val data = spark.range(0, 5)
data.write.format("delta").save("/root/data/warehouse/my-table")
```

