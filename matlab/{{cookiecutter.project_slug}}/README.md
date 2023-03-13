# {{ cookiecutter.project_name }} README

{{ cookiecutter.project_description }}.

## Version

Current version is {{ cookiecutter.version }} and was set according to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project's version should be updated, when applicable:

- In this very file.
- In the changelog.

## Prerequisites

This project was developed using matlab version {{ cookiecutter.matlab_version }}.

- **m2html***: open source documentation generator for matlab -> [m2html homepage](https://www.artefact.tk/software/matlab/m2html/)
- **log4m****: open source matlab logging facility -> [log4m - Matlab File Exchange](https://es.mathworks.com/matlabcentral/fileexchange/37701-log4m-a-powerful-and-simple-logger-for-matlab)

\* It has to be unzipped first (in the *tools* folder).
\*\* A slightly modified version (distributed in *tools* folder)

## Installation

The project's files must be available in matlab's path in order to work properly. To ensure this
condition, running the *add_project_to_path.m* script from the root folder should update the path
accordingly.

NOTE: it has to be run at every time after Matlab's application startup.

## Documentation

In order to generate documentation, simply run:

```bash
generate_documentation
```

### Help

Help information on the project's sources can be requested in Matlab by typing the following in the
command window:

```matlab
help <class_name>            % For a class definition documentation
help <class_name.class_name> % For the constructor documentation
help <class_name.method>     % For a class method documentation
help <function>              % For a function documentation
```

## Testing

For testing, the function run_tests (found in *test* folder) can execute all the defined tests or,
given a test name, It will run that particular one.

Optionally, test results can be exported to a .xlsx file for better display of the results.

```matlab
run_tests()                       % Will run all tests.
run_tests(["test_suite_name"])    % Will run test_suite_name tests.
run_tests([], true)               % Will run all tests and store the results in an .xlsx file located
                                  % in logs/test_results.xlsx.
```

## License

Developed by {{cookiecutter.full_name}} (c) {% now 'local', '%Y' %}

See license file for more information.

## Authors

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})

## Maintainer

- [{{cookiecutter.full_name}}]({{ cookiecutter.email }})
