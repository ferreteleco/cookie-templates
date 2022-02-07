# {{ cookiecutter.project_name }}

{{ cookiecutter.project_short_description }}

## Building

In order to build the library, execute the following commands:

```bash
# Create a new directory to perform an out of source build
$ mkdir build && cd build
# Configure build
$ cmake ..
# Perform build
$ cmake --build .
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
$ ./tests/unit/tests_unit
```

## Installing

In order to build and install the library, execute the following commands:

```bash
# Create a new directory to perform an out of source build
$ mkdir build && cd build
# Configure build
$ cmake ..
# Perform build
$ cmake --build .
# Install library
$ cmake --build . --target install
# Create a DEB package
$ cpack
```

By default, the library will be installed in the system directory, which might require
administrative permissions in order to perform the installation. It is possible to install the
library to a custom directory by specifying the following parameter during the configure step:

```bash
# Configure build
$ cmake -DCMAKE_INSTALL_PREFIX=<directory> ..
```

## Authors

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})
