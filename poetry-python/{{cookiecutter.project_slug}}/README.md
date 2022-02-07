# {{ cookiecutter.project_name }} README

{{ cookiecutter.project_description }}.

{% if cookiecutter.generate_poetry_file -%}
## Prerequisites

- [Poetry](https://github.com/python-poetry/poetry)
{% if cookiecutter.generate_pyenv_file %}
- [Pyenv](https://github.com/pyenv/pyenv)
{% endif -%}
{% endif -%}

{% if cookiecutter.generate_poetry_file -%}
## Installation

In order to install the project, simply run:

```bash
poetry install
```

{% endif -%}

{% if cookiecutter.generate_poetry_file -%}

## Building

In order to generate a .whl file to distribute the project, simply run:

```bash
poetry build
```

{% endif -%}

## Authors

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})
