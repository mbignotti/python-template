-include .env

# ========================================== Config ========================================== {{{

export SHELL              	:= /bin/bash
export PYTHON_VERSION     	= 3.12
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

.ONESHELL:
.PHONY: setup
setup:
	@curl -LsSf https://astral.sh/uv/install.sh | sh
	@uv python install $(PYTHON_VERSION)
	@uv python pin $(PYTHON_VERSION)
	@uv lock
	@uv sync
	@chmod u+x scripts/branch_names.sh
	@uv run pre-commit install
	@mkdir -p data data/raw data/processed data/final


.PHONY: lint
lint:
	@uv run pre-commit run --all
	@uv run ruff check --config $(PROJECT_ROOT)/pyproject.toml
	@uv run ruff format --config $(PROJECT_ROOT)/pyproject.toml

# }}}


# ========================================== Tests =========================================== {{{

.PHONY: test
test:
	@uv run pytest --junit-xml=test-reports/junit.xml --cov-report html:test-reports/coverage-report --cov={{ cookiecutter.project_slug }} $(TESTS_PATH) --html-report=test-reports/html-report

# }}}


# ========================================== Build =========================================== {{{

.PHONY: Build
build:
	uvx --from build pyproject-build --installer uv

# }}}