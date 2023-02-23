function json_struct = load_json_file(file_path)
    %LOAD_JSON_FILE Loads a json file into memory as a struct.
    %
    %   Input arguments:
    %
    %     - file_path: Path to the JSON file.
    %
    %   Output arguments:
    %
    %     - json_struct: Contents of the JSON inside a struct.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        file_path (1, 1) string {mustBeFile}
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MATLAB's logging (log4m) utility code. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global LOG;

    if isempty(LOG) || isfield(LOG, "dummy")
        LOG = struct('trace', @(varargin) 1, 'debug', @(varargin) 1, 'info', ...
        @(varargin) 1, 'warn', @(varargin) 1, 'timing', @(varargin) 1, ...
            'error', @(varargin) 1, 'fatal', @(varargin) 1, 'dummy', true);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    try

        LOG.debug(mfilename, sprintf("Loading JSON file from %s", file_path));
        fid = fopen(file_path);
        raw = fread(fid, inf);
        fclose(fid);
        json_struct = jsondecode(char(raw'));

    catch MExc
        LOG.error(mfilename,MExc.message);
        error(MExc.identifier, "Exception caught: %s", MExc.message);
    end
end
