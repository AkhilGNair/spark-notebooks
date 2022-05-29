up:
	docker-compose up -d

down:
	docker-compose down

clean:
	rm -r data/users.parquet || true

data: clean
	Rscript data/create.R
