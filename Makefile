# -*- coding: utf-8 -*-
# Auto generated from pygitrepo 0.0.21
#
# This Makefile is a dev-ops tool set.
# Compatible with:
#
# - Windows
# - MacOS
# - MacOS + pyenv + pyenv-virtualenv tool set
# - Linux
#
# The file structure should like this:
#
# repo_dir
#     |--- source_dir (package source code dir)
#         |--- __init__.py
#         |--- ...
#     |--- docs (documents dir)
#         |--- build (All build html will be here)
#         |--- source (doc source)
#         |--- Makefile (auto-generated by sphinx)
#         |--- make.bat (for windows)
#         |--- create_doctree.py (a tools automatically build doc tree)
#     |--- tests (unittest dir)
#         |--- all.py (run all test from python)
#         |--- ... (other test)
#     |--- README.rst (readme file)
#     |--- release-history.rst
#     |--- setup.py (installation behavior definition)
#     |--- requirements.txt (dependencies)
#     |--- requirements-dev.txt (dependencies for dev)
#     |--- requirements-doc.txt (dependencies for doc)
#     |--- requirements-test.txt (dependencies for test)
#     |--- LICENSE.txt
#     |--- MANIFEST.in (specified files need to be included in source code archive)
#     |--- tox.ini (tox setting)
#     |--- .travis.yml (travis-ci setting)
#     |--- .coveragerc (code coverage text setting)
#     |--- .gitattributes (git attribute file)
#     |--- .gitignore (git ignore file)
#     |--- fixcode.py (autopep8 source code and unittest code)
#
# Frequently used make command:
#
# - make up
# - make clean
# - make install
# - make test
# - make tox
# - make build_doc
# - make view_doc
# - make deploy_doc
# - make reformat
# - make publish


#--- User Defined Variable ---
PACKAGE_NAME="inspect_mate"

# Python version Used for Development
PY_VER_MAJOR="2"
PY_VER_MINOR="7"
PY_VER_MICRO="13"

#  Other Python Version You Want to Test With
# (Only useful when you use tox locally)
TEST_PY_VER3="3.4.6"
TEST_PY_VER4="3.5.3"
TEST_PY_VER5="3.6.2"

# Virtualenv Name
VENV_NAME="${PACKAGE_NAME}_venv"

# If you use pyenv-virtualenv, set to "Y"
USE_PYENV="Y"

# S3 Bucket Name
BUCKET_NAME="www.example.com"

#--- Derive Other Variable ---
CURRENT_DIR=${shell pwd}

ifeq (${OS}, Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname -s)
endif

# Windows
ifeq (${DETECTED_OS}, Windows)
    USE_PYENV="N"

    VENV_DIR_REAL="${CURRENT_DIR}/${VENV_NAME}"
    BIN_DIR="${VENV_DIR_REAL}/Scripts"
    SITE_PACKAGES="${VENV_DIR_REAL}/Lib/site-packages"

    GLOBAL_PYTHON="/c/Python${PY_VER_MAJOR}${PY_VER_MINOR}/python.exe"
    OPEN_COMMAND="start"
endif


# MacOS
ifeq (${DETECTED_OS}, Darwin)

ifeq ($(USE_PYENV), "Y")
    VENV_DIR_REAL="${HOME}/.pyenv/versions/${PY_VERSION}/envs/${VENV_NAME}"
    VENV_DIR_LINK="${HOME}/.pyenv/versions/${VENV_NAME}"
    BIN_DIR="${VENV_DIR_REAL}/bin"
    SITE_PACKAGES="${VENV_DIR_REAL}/lib/python${PY_VER_MAJOR}.${PY_VER_MINOR}/site-packages"
else
    VENV_DIR_REAL="${CURRENT_DIR}/${VENV_NAME}"
    VENV_DIR_LINK="./${VENV_NAME}"
    BIN_DIR="${VENV_DIR_REAL}/bin"
    SITE_PACKAGES="${VENV_DIR_REAL}/lib/python${PY_VER_MAJOR}.${PY_VER_MINOR}/site-packages"
endif

    GLOBAL_PYTHON="python${PY_VER_MAJOR}.${PY_VER_MINOR}"
    OPEN_COMMAND="open"
endif


# Linux
ifeq (${DETECTED_OS}, Linux)
    USE_PYENV="N"

    VENV_DIR_REAL="${CURRENT_DIR}/${VENV_NAME}"
    VENV_DIR_LINK="${CURRENT_DIR}/${VENV_NAME}"
    BIN_DIR="${VENV_DIR_REAL}/bin"
    SITE_PACKAGES="${VENV_DIR_REAL}/lib/python${PY_VER_MAJOR}.${PY_VER_MINOR}/site-packages"

    GLOBAL_PYTHON="python${PY_VER_MAJOR}.${PY_VER_MINOR}"
    OPEN_COMMAND="open"
endif

PROFILE_FILE = "${HOME}/.bash_profile"

BIN_ACTIVATE="${BIN_DIR}/activate"
BIN_PYTHON="${BIN_DIR}/python"
BIN_PIP="${BIN_DIR}/pip"
BIN_PYTEST="${BIN_DIR}/pytest"
BIN_SPHINX_START="${BIN_DIR}/sphinx-quickstart"
BIN_TWINE="${BIN_DIR}/twine"
BIN_TOX="${BIN_DIR}/tox"
BIN_JUPYTER="${BIN_DIR}/jupyter"


S3_PREFIX="s3://${BUCKET_NAME}/${PACKAGE_NAME}"
RTD_DOC_URL="https://inspect_mate.readthedocs.io/index.html"
AWS_DOC_URL="http://${BUCKET_NAME}.s3.amazonaws.com/${PACKAGE_NAME}/index.html"

PY_VERSION="${PY_VER_MAJOR}.${PY_VER_MINOR}.${PY_VER_MICRO}"


.PHONY: help
help: ## ** Show this help message
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


#--- Make Commands ---
.PHONY: info
info: ## ** Show information about python, pip in this environment
	@echo - venv: ${VENV_DIR_REAL} "\n"
	@echo - python executable: ${BIN_PYTHON} "\n"
	@echo - pip executable: ${BIN_PIP} "\n"
	@echo - document on rtd: ${RTD_DOC_URL} "\n"
	@echo - document on s3: ${AWS_DOC_URL} "\n"
	@echo - site-packages: ${SITE_PACKAGES} "\n"


#--- Virtualenv ---
.PHONY: brew_install_pyenv
brew_install_pyenv: ## Install pyenv and pyenv-virtualenv
	-brew install pyenv
	-brew install pyenv-virtualenv


.PHONY: enable_pyenv
enable_pyenv: ## Config $HOME/.bash_profile file
	if ! grep -q 'export PYENV_ROOT="$$HOME/.pyenv"' "${PROFILE_FILE}" ; then\
	    echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'export PATH="$$PYENV_ROOT/bin:$$PATH"' "${PROFILE_FILE}" ; then\
	    echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'eval "$$(pyenv init -)"' "${PROFILE_FILE}" ; then\
	    echo 'eval "$$(pyenv init -)"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'eval "$$(pyenv virtualenv-init -)"' "${PROFILE_FILE}" ; then\
	    echo 'eval "$$(pyenv virtualenv-init -)"' >> "${PROFILE_FILE}" ;\
	fi


.PHONY: setup_pyenv
setup_pyenv: brew_install_pyenv enable_pyenv ## Do some pre-setup for pyenv and pyenv-virtualenv
	pyenv install ${PY_VERSION} -s
	pyenv rehash


.PHONY: init_venv
init_venv: ## Initiate Virtual Environment
ifeq (${USE_PYENV}, "Y")
	# Install pyenv
	-brew install pyenv
	-brew install pyenv-virtualenv

	# Edit Config File
	if ! grep -q 'export PYENV_ROOT="$$HOME/.pyenv"' "${PROFILE_FILE}" ; then\
	    echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'export PATH="$$PYENV_ROOT/bin:$$PATH"' "${PROFILE_FILE}" ; then\
	    echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'eval "$$(pyenv init -)"' "${PROFILE_FILE}" ; then\
	    echo 'eval "$$(pyenv init -)"' >> "${PROFILE_FILE}" ;\
	fi
	if ! grep -q 'eval "$$(pyenv virtualenv-init -)"' "${PROFILE_FILE}" ; then\
	    echo 'eval "$$(pyenv virtualenv-init -)"' >> "${PROFILE_FILE}" ;\
	fi

	pyenv install ${PY_VERSION} -s
	pyenv rehash

	-pyenv virtualenv ${PY_VERSION} ${VENV_NAME}
else
	virtualenv -p ${GLOBAL_PYTHON} ${VENV_NAME}
endif


.PHONY: up
up: init_venv ## ** Set Up the Virtual Environment


.PHONY: clean
clean: ## ** Clean Up Virtual Environment
ifeq (${USE_PYENV}, "Y")
	-pyenv uninstall -f ${VENV_NAME}
else
	-rm -r ${VENV_DIR_REAL}
endif


#--- Install ---
.PHONY: uninstall
uninstall: ## ** Uninstall This Package
	-${BIN_PIP} uninstall -y ${PACKAGE_NAME}


.PHONY: install
install: uninstall ## ** Install This Package via setup.py
	${BIN_PIP} install .


.PHONY: dev_install
dev_install: uninstall ## ** Install This Package in Editable Mode
	${BIN_PIP} install --editable .


.PHONY: dev_dep
dev_dep: ## Install Development Dependencies
	${BIN_PIP} install -r requirements-dev.txt


.PHONY: test_dep
test_dep: ## Install Test Dependencies
	${BIN_PIP} install -r requirements-test.txt


.PHONY: doc_dep
doc_dep: ## Install Doc Dependencies
	${BIN_PIP} install -r requirements-doc.txt


#--- Test ---

.PHONY: test
test: dev_install test_dep ## ** Run test
	${BIN_PYTEST} tests -s


.PHONY: test_only
test_only: ## Run test without checking dependencies
	${BIN_PYTEST} tests -s


.PHONY: cov
cov: dev_install test_dep ## ** Run Code Coverage test
	${BIN_PYTEST} tests -s --cov=${PACKAGE_NAME} --cov-report term --cov-report annotate:.coverage.annotate


.PHONY: cov_only
cov_only: ## Run Code Coverage test without checking dependencies
	${BIN_PYTEST} tests -s --cov=${PACKAGE_NAME} --cov-report term --cov-report annotate:.coverage.annotate


.PHONY: tox
tox: ## ** Run tox
	${BIN_PIP} install tox
	( \
		pyenv local 2.7.13 3.4.6 3.5.3 3.6.2; \
		${BIN_TOX}; \
	)


#--- Sphinx Doc ---
.PHONY: init_doc
init_doc: doc_dep ## Initialize Sphinx Documentation Library
	{ \
		cd docs; \
		${BIN_SPHINX_START}; \
	}


.PHONY: build_doc
build_doc: doc_dep dev_install ## ** Build Documents, force Update
	${BIN_PYTHON} ./docs/create_doctree.py
	( \
		source ${BIN_ACTIVATE}; \
		cd docs; \
		make html; \
	)


.PHONY: build_doc_again
build_doc_again: ## Build Documents, Don't Check Dependencies
	${BIN_PYTHON} ./docs/create_doctree.py
	( \
		source ${BIN_ACTIVATE}; \
		cd docs; \
		make html; \
	)


.PHONY: view_doc
view_doc: ## ** Open Documents
	${OPEN_COMMAND} ./docs/build/html/index.html


.PHONY: deploy_doc
deploy_doc: ## ** Deploy Document to AWS S3
	aws s3 rm ${S3_PREFIX} --recursive
	aws s3 sync ./docs/build/html ${S3_PREFIX}


.PHONY: clean_doc
clean_doc: ## Clean Existing Documents
	rm -r ./docs/build


.PHONY: reformat
reformat: dev_dep ## ** Pep8 Format Source Code
	${BIN_PYTHON} fixcode.py


.PHONY: publish
publish: dev_dep ## ** Publish This Library to PyPI
	${BIN_PYTHON} setup.py sdist bdist_wheel
	${BIN_TWINE} upload dist/*
	-rm -rf build dist .egg ${PACKAGE_NAME}.egg-info


.PHONY: notebook
notebook: ## ** Run jupyter notebook
	${BIN_PIP} install jupyter
	${BIN_JUPYTER} notebook