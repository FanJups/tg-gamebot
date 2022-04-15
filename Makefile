.DEFAULT_GOAL := help

VENV_PATH=venv
PYTHON_BIN=$(VENV_PATH)/bin/python3
APP_DIR="./src/app"

.PHONY: venv
venv: $(VENV_PATH)/bin/activate
$(VENV_PATH)/bin/activate: requirements.txt
	test -d $(VENV_PATH) || virtualenv -p python3 $(VENV_PATH); \
	. $(VENV_PATH)/bin/activate; \
	pip install -r requirements.txt
	touch $(VENV_PATH)/bin/activate

.PHONY: launch
launch:
	@echo "Launching bot..."
	$(PYTHON_BIN) $(APP_DIR)/main.py

.PHONY: test
test:
	@echo "Testing"
	pytest $(APP_DIR)

.PHONY: lint
lint:
	@echo "Linting..."
	flake8 $(APP_DIR)

.PHONY: install-deps
install-deps:
	@echo "Installing dependencies"
	pip install -r requirements.txt

.PHONY: uninstall-deps
uninstall-deps:
	@echo "Uninstalling dependencies..."
	pip uninstall -r requirements.txt

.PHONY: update
update:
	@echo "Updating dependencies..."
	pip install --upgrade -r requirements.txt

.PHONY: clean
clean:
	@echo "Cleaning up"
	rm -rf $(APP_DIR)/__pycache__
	rm -rf $(APP_DIR)/main.pyc



.PHONY: help
help:
	@echo "Usage: make [command]"
	@echo "Commands:"
	@echo "  run: run the bot"
	@echo "  test: run the tests"
	@echo "  lint: run the linter"
	@echo "  clean: clean the bot"
	@echo "  install-deps: install dependencies"
	@echo "  help: show this help"

