function parent_path = get_file_base_path(current_file_path, no_parents_to_skip)
    % get_file_base_path Computes the base folder of a given file path an specified number of 
    % parents below.
    %
    %   This functions receives an input absolute file path (that does not matter if exist or not)
    %   and then it computes the base path using the specified number of parent directories to skip.
    %   The existence of the resulting folder path is then checked, returning empty string upon
    %   failure.
    %
    %   Note that resulting path is missing the last file separator (filesep).
    %
    %   Input arguments:
    % 
    %     - current_file_path: Base path to perform de base folder adquisition.
    % 
    %     - no_parents_to_skip: Number of parents to skip in generating the base path.
    %
    % Output arguments:
    % 
    %     - parent_path: generated parent path.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        current_file_path (1, 1) string
        no_parents_to_skip (1, 1) double {mustBeNonnegative, mustBeInteger, ...
                                        mustBeLessThan(no_parents_to_skip, 5)}
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MATLAB's logging (log4m) utility code. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global LOG;
    if isempty(LOG) || isfield(LOG, "dummy")
    LOG = struct('trace', @(varargin) 1, 'debug', @(varargin) 1, 'info', @(varargin) 1, ...
        'warn', @(varargin) 1, 'timing', @(varargin) 1, 'error', @(varargin) 1, 'fatal', ...
        @(varargin) 1, 'dummy', true);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    path_tokens = split(current_file_path, filesep);
    LOG.info(mfilename, sprintf("File location is %s", ...
        string(join(path_tokens(1:end - 1), filesep))));
    candidate = string(join(path_tokens(1:end - no_parents_to_skip - 1), filesep));

    if isfolder(candidate)
        LOG.info(mfilename, sprintf("Parent (%d) location is %s", no_parents_to_skip, candidate));
        parent_path = candidate;
    else
        LOG.warn(mfilename, 'Requested parent is not valid');
        parent_path = "";
    end

end
