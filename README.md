# vitanum-deployment
Contains scripts and docker files which will, in the end, deploy the entire Vitanum application

Vitanum is a project which allows the user to log the consumed foods and drinks, search for the richest foods in a certain nutrient (e.g. Iron).
The nutritional values and the list of foods are retrieved by using the USDA Rest API (see https://fdc.nal.usda.gov/help.html).

See the README files of the involved projects:

- https://github.com/cdinescu/vitanum-frontend
- https://github.com/cdinescu/gateway-service
- https://github.com/cdinescu/eureka-service
- https://github.com/cdinescu/users-service
- https://github.com/cdinescu/diary-service
- https://github.com/cdinescu/food-service
- https://github.com/cdinescu/config-server
- https://github.com/cdinescu/ask-oracle-service

Note: some repos are private (due to USDA API key being present in the configuration files)

<hr>
Technology stack:

- Spring Framework
- Spring Cloud
- Spring Security (the user authentication and authorization are currently being developed)
- Spring Data Rest
- Hibernate
- Angular
- Docker (this is the current deployment)
- Kubernetes (the migration from Docker to Kubernetes is currently being developed)
- Travis CI
- Gradle

<hr>
Dockerhub repositories:

- https://hub.docker.com/repository/docker/villanelle/vitanum-naming-server
- https://hub.docker.com/repository/docker/villanelle/vitanum-config-server
- https://hub.docker.com/repository/docker/villanelle/vitanum-gateway-service
- https://hub.docker.com/repository/docker/villanelle/vitanum-food-service
- https://hub.docker.com/repository/docker/villanelle/vitanum-ask-oracle-service
- https://hub.docker.com/repository/docker/villanelle/vitanum-diary

