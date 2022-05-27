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

