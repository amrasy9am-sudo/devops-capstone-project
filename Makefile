.PHONY: help install lint test run db

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  %-10s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## Install Python dependencies
	python3 -m pip install --upgrade pip wheel
	pip install -r requirements.txt

lint: ## Run the linter
	flake8 service tests --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 service tests --count --max-complexity=10 --max-line-length=127 --statistics

test: ## Run the unit tests
	nosetests

run: ## Run the service
	honcho start

db: ## Run PostgreSQL in Docker
	docker run -d --name postgresql \
		-e POSTGRES_PASSWORD=postgres \
		-p 5432:5432 \
		postgres:alpine
