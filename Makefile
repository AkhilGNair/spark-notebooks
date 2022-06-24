build:
	docker-compose build

up:
	docker-compose up

down:
	docker-compose down

clean:
	rm -r data/users.parquet || true

data: clean
	Rscript data/create.R
