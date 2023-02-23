function res = simple_add(a, b)
  %SIMPLE_ADD Adds two numbers.
  %
  %   Input arguments:
  %
  %     - a: First number.
  %
  %     - b: Second number.
  %
  %   Output arguments:
  %
  %     - res: Result of the sum.
  %
  % Author: {{ cookiecutter.full_name }} ({{ cookiecutter.email }})
  % Project: {{ cookiecutter.project_name }}
  %
  % Matlab Version: {{ cookiecutter.matlab_version }}
  % Copyright (c) {% now 'local', '%Y' %} {{ cookiecutter.full_name }}
  
  arguments
      a (1, 1) double
      b (1, 1) double
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % MATLAB's logging (log4m) utility code. You can safely ignore it.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  global LOG;
  if isempty(LOG) || isfield(LOG, "dummy")
  LOG = struct('trace', @(varargin) 1, 'debug', @(varargin) 1, 'info', ...
  @(varargin) 1, 'warn', @(varargin) 1, 'timing', @(varargin) 1, 'error', @(varargin) 1, ...
  'fatal', @(varargin) 1, 'dummy', true);
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  res = a + b;

  LOG.trace(mfilename, sprintf("Sum result is: %d", res));

end
