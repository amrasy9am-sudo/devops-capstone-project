# DevOps Capstone Project – Customer Accounts Microservice

![Build Status](https://github.com/amrasy9am-sudo/devops-capstone-project/actions/workflows/ci-build.yaml/badge.svg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Python 3.9](https://img.shields.io/badge/Python-3.9-green.svg)](https://shields.io/)

**Project name:** devops-capstone-project
**Author:** Mohamad Amirul Asyraf

This repository contains the work for the **IBM DevOps and Software Engineering Capstone Project**.
It is a RESTful **Customer Accounts** microservice built with Flask and PostgreSQL, tested with
nose, checked with flake8, secured with Flask-Talisman and Flask-CORS, containerized with Docker,
deployed to Kubernetes/OpenShift, and automated with GitHub Actions (CI) and Tekton (CD).

## REST API

| Method | URL | Description |
|---|---|---|
| `GET` | `/health` | Health check |
| `GET` | `/` | Service name and version |
| `POST` | `/accounts` | Create an account |
| `GET` | `/accounts` | List all accounts |
| `GET` | `/accounts/<id>` | Read an account |
| `PUT` | `/accounts/<id>` | Update an account |
| `DELETE` | `/accounts/<id>` | Delete an account |

## Account model

| Field | Type |
|---|---|
| id | Integer (primary key) |
| name | String(64) |
| email | String(64) |
| address | String(256) |
| phone_number | String(32), optional |
| date_joined | Date |

## Run locally

```bash
bash bin/setup.sh
exit                 # start a new terminal so the venv activates
make db              # start PostgreSQL in Docker
pip install -r requirements.txt
nosetests            # run the tests (config in setup.cfg)
honcho start         # start the service
```

## Project layout

```text
.github/workflows/ci-build.yaml   CI with GitHub Actions
.github/ISSUE_TEMPLATE/user-story.md
.tekton/                          CD pipeline (Tekton)
deploy/                           Kubernetes manifests
service/                          Flask service (models, routes, config)
tests/                            Unit tests
Dockerfile                        Container image
setup.cfg                         nose, coverage, flake8 and pylint config
```
