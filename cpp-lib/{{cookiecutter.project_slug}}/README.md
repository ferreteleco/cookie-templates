# {{ cookiecutter.project_name }}

{{ cookiecutter.project_short_description }}

## Version

Current version is {{cookiecutter.version}} and was set according to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project's version should be updated, when applicable:

- In this very file.
- In the changelog.
- In the base CMakeLists.txt file.

## Prerequisites

This project makes use of the following external dependencies:

- [Catch2](https://github.com/catchorg/Catch2): testing framework. Defaults to version 3.0.0, please
  update accordingly.

{%- if cookiecutter.add_spdlog_utils == 'True' %}
- [spdlog](https://github.com/gabime/spdlog): logging framework. The project also includes a 
  configuration function for it that has to be executed first in the main function in order to setup
  logging.
{%- endif %}

## Building

In order to build the library, execute the following commands:

```bash
# Configure build
$ cmake -S . -B build
# Perform build
$ cmake --build build
```

## Testing

In order to build and run the unit tests for this library, execute the following commands:

```bash
# Create a new directory to perform an out of source build
$ mkdir build && cd build
# Configure build
$ cmake ..
# Build unit tests
$ cmake --build . --target tests
# Run unit tests
$ ./tests/unit/${{cookiecutter.project_slug}}_unit_tests
```

## Installing

In order to build and install the library, execute the following commands:

```bash
# Create a new directory to perform an out of source build
# Configure build
$ cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
# Perform build
$ cmake --build build
# Install library
$ cmake --install build
# OR Create a DEB package (optional)
$ cd build
$ cpack
```

By default, the library will be installed in the system directory, which might require
administrative permissions in order to perform the installation. It is possible to install the
library to a custom directory by specifying the following parameter during the configure step:

```bash
# Configure build
$ cmake -S . -B build -DCMAKE_INSTALL_PREFIX=<directory> -DCMAKE_BUILD_TYPE=Release
```

## Authors

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})
