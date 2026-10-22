# User stories (copy each one into a new GitHub issue)

Create each issue with the **User Story** template. Labels and story points are listed under each story.

---

## Sprint 1 – Customer Accounts MVP

### 1. Setting up the development environment
**Label:** technical debt · **Estimate:** 3

**As a** developer
**I need** a working development environment with linting and test configuration
**So that** I can write and test code for the accounts service

**Details and Assumptions**
* Use the lab environment and `bin/setup.sh`
* `setup.cfg` configures nosetests, coverage, flake8 and pylint

**Acceptance Criteria**
```gherkin
Given the code is cloned from the repository
When I run nosetests
Then all tests run and a coverage report is shown
```

### 2. Create an account in the service
**Label:** enhancement · **Estimate:** 3

**As a** customer
**I need** to create an account
**So that** I can use the services of the store

**Details and Assumptions**
* An account has name, email, address, phone_number and date_joined
* `POST /accounts` returns `201 Created` and a `Location` header

**Acceptance Criteria**
```gherkin
Given the accounts service is running
When I send a POST request to /accounts with valid account data
Then a new account is created and returned with status 201
```

### 3. Read an account from the service
**Label:** enhancement · **Estimate:** 3

**As a** customer
**I need** to read my account details
**So that** I can see the information the store has about me

**Details and Assumptions**
* `GET /accounts/<id>` returns `200 OK`, or `404 Not Found` if the account does not exist

**Acceptance Criteria**
```gherkin
Given an account exists in the service
When I send a GET request to /accounts/<id>
Then the account details are returned with status 200
```

### 4. Update an account in the service
**Label:** enhancement · **Estimate:** 3

**As a** customer
**I need** to update my account details
**So that** my information stays correct

**Details and Assumptions**
* `PUT /accounts/<id>` returns `200 OK`, or `404 Not Found` if the account does not exist

**Acceptance Criteria**
```gherkin
Given an account exists in the service
When I send a PUT request to /accounts/<id> with new data
Then the account is updated and returned with status 200
```

### 5. Delete an account from the service
**Label:** enhancement · **Estimate:** 3

**As a** customer
**I need** to delete my account
**So that** my data is removed when I no longer use the store

**Details and Assumptions**
* `DELETE /accounts/<id>` returns `204 No Content`

**Acceptance Criteria**
```gherkin
Given an account exists in the service
When I send a DELETE request to /accounts/<id>
Then the account is removed and status 204 is returned
```

### 6. List all accounts in the service
**Label:** enhancement · **Estimate:** 3

**As a** store administrator
**I need** to list all accounts
**So that** I can see who my customers are

**Details and Assumptions**
* `GET /accounts` returns a JSON list (empty list if there are no accounts)

**Acceptance Criteria**
```gherkin
Given accounts exist in the service
When I send a GET request to /accounts
Then a list of all accounts is returned with status 200
```

### 7. Containerize your microservice using Docker (Ice Box)
**Label:** technical debt · **Estimate:** 5

**As a** developer
**I need** to containerize the accounts service with Docker
**So that** it can be deployed to a Kubernetes cluster

**Acceptance Criteria**
```gherkin
Given a Dockerfile exists in the repository
When I run docker build
Then an image named accounts is created
```

### 8. Deploy your Docker image to Kubernetes (Ice Box)
**Label:** technical debt · **Estimate:** 8

**As a** service provider
**I need** the service to run on Kubernetes
**So that** I can easily scale and manage the service

**Acceptance Criteria**
```gherkin
Given the accounts image is in a container registry
When I apply the deployment and service manifests
Then the accounts service is running on Kubernetes
```

### 9. Create a CD pipeline to automate deployment to Kubernetes (Ice Box)
**Label:** technical debt · **Estimate:** 8

**As a** developer
**I need** to create a CD pipeline to automate deployment to Kubernetes
**So that** the developers are not wasting their time doing it manually

**Acceptance Criteria**
```gherkin
Given the Tekton pipeline is installed
When I start the pipeline with the repo URL and branch
Then the code is linted, tested, built and deployed automatically
```

---

## Sprint 2

### 10. Need the ability to automate continuous integration checks
**Label:** technical debt · **Estimate:** 5

**As a** developer
**I need** automated CI checks with GitHub Actions
**So that** every pull request is linted and tested

**Acceptance Criteria**
```gherkin
Given code is pushed or a pull request is opened on main
When GitHub Actions runs the CI Build workflow
Then the code is linted with flake8 and tested with nosetests
```

### 11. Need to add security headers and CORS policies
**Label:** technical debt · **Estimate:** 3

**As a** service provider
**I need** security headers and CORS policies on the service
**So that** the service is protected from common web attacks

**Acceptance Criteria**
```gherkin
Given the accounts service is running
When a request is made to the service
Then security headers and an Access-Control-Allow-Origin header are returned
```

---

## Sprint 3

Move stories 7, 8 and 9 from the Ice Box into the Sprint Backlog.
