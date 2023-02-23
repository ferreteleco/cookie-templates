function tests = tests_demo
    %TESTS_DEMO Performs a simple dummy check in order to demonstrate testing framework procedures.
    %
    % Author: {{ cookiecutter.full_name }} ({{ cookiecutter.email }})
    % Project: {{ cookiecutter.project_name }}
    %
    % Matlab Version: {{ cookiecutter.matlab_version }}
    % Copyright (c) {% now 'local', '%Y' %} {{ cookiecutter.full_name }}

    tests = functiontests(localfunctions);
end

function setupOnce(~)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MATLAB's logging (log4m) utility code. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global LOG;

    if isempty(LOG) || isfield(LOG, "dummy")
        LOG = struct('trace', @(varargin) 1, 'debug', @(varargin) 1, 'info', ...
            @(varargin) 1, 'warn', @(varargin) 1, 'timing', @(varargin) 1, ...
            'error', @(varargin) 1, 'fatal', @(varargin) 1, 'dummy', true);
    else
        LOGS_FOLDER = "./logs";
        LOG_NAME = strcat("log_name_", get_UTC_datetime_string());
        LOG.setFilename(sprintf("%s/%s.log", LOGS_FOLDER, LOG_NAME));
        LOG.setLogLevel(log4m.OFF);
        LOG.setCommandWindowLevel(log4m.OFF);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function test_demo_procedure(~)

    % Inputs
    input_a = 1;
    input_b = 2;

    % Expected output
    expected = 3;

    % Function under test
    computed = simple_sum(input_a, input_b);

    % Checks
    assert(length(computed) == length(expected));
    assert(expected == computed);
end
