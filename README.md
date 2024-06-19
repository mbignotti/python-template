Python template repository
===

A simple template repository to kickstart new, linux-based, python projects.

Simply look for the `template` keyword and replace it with the appropriate project name.

Requirements
---

* A linux-based environment.
* Python 3.11 installed.
* GNU Make.

Workflow
---

* Replace the `template` keyword with the desired project name.
* Run `make setup` to setup a new development environment.
* Run `make venv` to generate a new virtual environment only.
* Run `make update-deps-all` to generate/updated locked dependency files.
* Run `make lint` to run linting and pre-commit checks.
* Run `make test` to run unit tests and generate test reports.
* Run `make install-all` to install all the locked dependencies (to be used in production).
