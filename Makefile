.PHONY: build
build: ## Build the docker image.
	docker compose -f docker-compose.yml build

.PHONY: start
start: ## Start the docker container.
	docker compose -f docker-compose.yml up -d

.PHONY: scale
scale: ## Start the docker container with 2 instances of each microservice.
	docker compose -f docker-compose.yml up -d --scale workflow-service=2 --scale notification-service=2 --scale rulechain-service=2 --scale details-service=2

.PHONY: stop
stop: ## Stop the docker container.
	docker compose -f docker-compose.yml down

.PHONY: restart
restart: stop start ## Restart the docker container.

.PHONY: restart-service
restart-service: ## Restart a specific service. Usage: make restart-service SERVICE=service-name
	docker compose -f docker-compose.yml stop $(SERVICE)
	docker compose -f docker-compose.yml rm -f $(SERVICE)
	docker compose -f docker-compose.yml up -d $(SERVICE)

.PHONY: logs
logs: ## View docker container logs.
	docker compose -f docker-compose.yml logs -f

.PHONY: shell
shell: ## Open a shell in the running container.
	docker compose -f docker-compose.yml exec app sh

.PHONY: clean
clean: ## Remove all docker containers, images, and volumes.
	docker compose -f docker-compose.yml down -v --rmi all