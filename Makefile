postgres:
	docker start postgres-docker
	# docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=admin123 -d postgres:12-alpine

createdb:
	docker exec -it postgres-docker createdb --username=postgres --owner=postgres simple_bank
	# docker exec -it postgres-docker createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-docker dropdb --username=postgres simple_bank
	# docker exec -it postgres-docker dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:admin123@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:admin123@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown