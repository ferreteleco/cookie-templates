# Cookiecutter project for various languages and options

This repository can be used for generating a number of project structures in a number of different
languages.

## Usage

In order to start a new project, install [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) and run the following command:

```bash
$ cookiecutter https://github.com/ferreteleco/cookie-templates.git --directory="<dir-name>"
```

Where \<dir-name\> is one of the sub-folders of this repository (each one will hold a template for a 
different kind of project). Each available template can be seen in sub-sections below.

**IMPORTANT!** This will create the full structure for the project (including top level directory),
so it is recommended that the project generation be invoked from outside vscode. The remote
repository may be linked later by running the following commands (inside the top level directory of
the project):

```bash
git init
git remote add origin <remote-repository-url>
```

NOTE: it can also be cloned using GIT over SSH, if properly configured in your account.

NOTE1: after the repository is downloaded, the template can be used again without downloading it
again. In order to do so, simply specify template name as argument for cookiecutter:

```bash
$ cookiecutter com-cookiecutter-templates --directory="<dir-name>"
```

## Cpp executable template (dir-name: cpp-exe)

A [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) template for Cpp projects
(executable version).

### Dependencies

As its base (currently configured in the template), this projects only depends on one external
library:

- [Catch2](https://github.com/catchorg/Catch2)

### Variables

Variables allow to customize your project. When running the previous command, you will be prompted
to fill in the following values:

- _**project_name**_: Name of the project. This variable will also be used to create the default
  value for the project slug.
- _**project_slug**_: URL friendly name of the project. It is recommended to keep the default value.
- _**project_short_description**_: Short description of the project.
- _**version**_: Initial version of the project. If using a different value from the default, please
  follow [Semantic Versioning](https://semver.org/) recommendations.
- _**cpp_standard**_: C++ standard to use for compilation. Available values are C++17 (default),
  C++14 and C++11.
- _**full_name**_: Full name of the main maintainer of the project.
- _**email**_: Contact email of the main maintainer of the project.
- _**license**_: default license file for the project.

## Cpp library template (dir-name: cpp-lib)

A [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) template for Cpp projects (library
version).

### Dependencies

As its base (currently configured in the template), this projects only depends on one external
library:

- [Catch2](https://github.com/catchorg/Catch2)

### Variables

Variables allow to customize your project. When running the previous command, you will be prompted
to fill in the following values:

- _**project_name**_: Name of the project. This variable will also be used to create the default
  value for the project slug.
- _**project_slug**_: URL friendly name of the project. It is recommended to keep the default value.
- _**project_short_description**_: Short description of the project.
- _**version**_: Initial version of the project. If using a different value from the default, please
  follow [Semantic Versioning](https://semver.org/) recommendations.
- _**cpp_standard**_: C++ standard to use for compilation. Available values are C++17 (default),
  C++14 and C++11.
- _**library_type**_: kind of library to build, either shared (default) or static.
- _**full_name**_: Full name of the main maintainer of the project.
- _**email**_: Contact email of the main maintainer of the project.
- _**license**_: default license file for the project.

## Python module (with poetry support) (dir-name: python)

A [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) template for python projects.

### Dependencies

This template is intended to be used with the following libraries for environment and package
management:

- [Poetry](https://github.com/python-poetry/poetry)
- [Pyenv](https://github.com/pyenv/pyenv)

Although it can be used without them.

### Variables

Variables allow to customize your project. When running the previous command, you will be prompted
to fill in the following values:

- _**project_name**_: name of the project. This variable will also be used to create the default
  value for the project slug.
- _**project_slug**_: URL friendly name of the project. It is recommended to keep the default value.
- _**project_description**_: short description of the project.
- _**project_version**_: initial version of the project. If using a different value from the
  default, please follow [Semantic Versioning](https://semver.org/) recommendations.
- _**python_version**_: minimum required Python version in order to run the program.
- _**generate_pyenv_file**: flag to control generation of .python-version file (local Python version
  definition file for pyenv).
- _**generate_poetry_file**_: flag to control generation of pyproject.toml file (Poetry build system
  definition file).
- _**vscode_project**_: flag to control generation of .vscode folder, with default tasks.json file
  (VSCode text editor config files)
- _**full_name**_: full name of the main maintainer of the project.
- _**email**_: contact email of the main maintainer of the project.
- _**license**_: default license file for the project.

## Contributing

If you want to contribute to this templating repository, feel free to do so! Create a new branch to
work in and open a pull request when you are done! It will be reviewed and merged into master by one
of the maintainers as soon as possible.

## Authors

- [@ferreteleco](https://www.github.com/ferreteleco)

## Maintainers

- [@ferreteleco](https://www.github.com/ferreteleco)
