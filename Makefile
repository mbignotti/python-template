-include .env

# ========================================== Config ========================================== {{{

export SHELL              	:= /bin/bash
export PYTHON_VERSION     	= 3.11
export VENV_NAME          	= $(PROJECT_NAME)-$(PYTHON_VERSION)
export VENV_PATH			= .venv
export MAKE_VENV			= python$(PYTHON_VERSION) -m venv --prompt $(VENV_NAME) $(VENV_PATH)
export ACTIVATE_VENV		= source $(VENV_PATH)/bin/activate
export PROJECT_ROOT			= $(PWD)
export TESTS_PATH			= $(PROJECT_ROOT)/tests/


TARGETS = dev test notebooks
UPDATE_TARGET_REQUIREMENTS = $(addprefix update-deps-,$(TARGETS))
INSTALL_TARGET_REQUIREMENTS = $(addprefix install-,$(TARGETS))

# }}}

# ======================================== Welcome ========================================== {{{

.PHONY: default
default:
	@echo "$(PROJECT_NAME) - Version ${PROJECT_VERSION}"

# }}}


# ======================================== Dev setup ========================================= {{{

.PHONY: setup
setup: venv
	@$(VENV_PATH)/bin/pip install -e ".[all]"
	@chmod u+x scripts/branch_names.sh
	@$(ACTIVATE_VENV) && pre-commit install
	@mkdir -p data data/raw data/processed data/final


.ONESHELL:
.PHONY: venv
venv:
	@if ! [ -f .env ]; then
		cp .env.sample .env;
	@fi;
	@echo "Creating virtualenv at $(VENV_PATH)"
	@$(MAKE_VENV)
	@$(VENV_PATH)/bin/pip install --upgrade pip



.PHONY: $(UPDATE_TARGET_REQUIREMENTS)
$(UPDATE_TARGET_REQUIREMENTS): update-deps-%:
	@$(ACTIVATE_VENV) && pip-compile --upgrade --verbose --resolver backtracking -o requirements/requirements.txt pyproject.toml
	@$(ACTIVATE_VENV) && pip-compile --upgrade --verbose --extra $* --resolver backtracking -o requirements/$*-requirements.txt pyproject.toml


.PHONY: update-deps-all
update-deps-all: $(UPDATE_TARGET_REQUIREMENTS)


.PHONY: lint
lint:
	@$(ACTIVATE_VENV) && pre-commit run --all
	@$(ACTIVATE_VENV) && ruff check --config $(PROJECT_ROOT)/pyproject.toml
	@$(ACTIVATE_VENV) && ruff format --config $(PROJECT_ROOT)/pyproject.toml

# }}}


# ======================================== Install ========================================== {{{

.PHONY: $(INSTALL_TARGET_REQUIREMENTS)
$(INSTALL_TARGET_REQUIREMENTS): install-%: venv
	@$(ACTIVATE_VENV) && pip install -r requirements/requirements.txt
	@$(ACTIVATE_VENV) && pip install -r requirements/$*-requirements.txt


.PHONY: install-all
install-all: $(INSTALL_TARGET_REQUIREMENTS)

#}}}


# ========================================== Tests =========================================== {{{

.PHONY: test
test:
	@$(ACTIVATE_VENV) && pytest --junit-xml=test-reports/junit.xml --cov-report html:test-reports/coverage-report --cov=template $(TESTS_PATH) --html-report=test-reports/html-report

# }}}
