# {{ cookiecutter.project_name }} README

{{ cookiecutter.project_description }}.

## Version

Current version is {{cookiecutter.version}} and was set according to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project's version should be updated, when applicable:

- In this very file.
- In the changelog.
- In the base \_\_init\_\_.py file ({{cookiecutter.project_slug}}/\_\_init\_\_.py).

{% if cookiecutter.generate_poetry_file -%}
## Prerequisites

- [Poetry](https://github.com/python-poetry/poetry)
{% if cookiecutter.generate_pyenv_file %}
- [Pyenv](https://github.com/pyenv/pyenv)
{% endif %}
## Documentation

In order to generate documentation, simply run:

```bash
poetry run pdoc -o docs -d google {{cookiecutter.project_slug}}
```

## Installation

In order to install the project, simply run:

```bash
poetry install
```

## Building

In order to generate a .whl file to distribute the project, simply run:

```bash
poetry build
```

{% endif -%}

## Authors

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})
