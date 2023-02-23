function output = from_bin_file(file_location, data_type)
    %FROM_BIN_FILE Loads a binary vector using the specified data type into matlab (as column 
    % vector).
    % 
    %   Note that, if the specified file name does not terminate in a file extension, '.bin' is
    %   assumed for file read.
    % 
    %   Also, the specified data type gets compared with the one appended to the end of the 
    %   filename, just before the file extension (if found) and raises a warning if they do not 
    %   match.
    %
    %   Input arguments:
    %   
    %       - file_location: Location of the file to be loaded into matlab.
    % 
    %       - data_type: Format of the binary data to read. Defaults to uint8.
    %
    %   Output arguments:
    % 
    %       - output: Parsed content of the file.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        file_location (1, 1) string
        data_type (1, 1) string {mustBeMember(data_type, ...
            ["uint8", "uint16", "uint32", "uint64", ...
                "int8", "int16", "int32", "int64", "double", "c32", "c64"]) ...
                            } = "uint8"
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

    DATA_TYPE_PATTERN = "_" + alphanumericsPattern(1, 6) + ".";
    sanitized_file_location = adapt_path_to_os(file_location);

    if (~endsWith(sanitized_file_location, ".bin"))
        WARN_MSG = "File extension not specified, assuming .bin";
        warning("FromBinFile:missingExtension", WARN_MSG);
        LOG.warn(mfilename,WARN_MSG);
        sanitized_file_location = strcat(sanitized_file_location, ".bin");
    end

    try
        spec_data_type = extract(sanitized_file_location, DATA_TYPE_PATTERN);
        spec_data_type = extractBetween(spec_data_type, 2, strlength(spec_data_type) -1);

        if (~strcmp(spec_data_type, "")) && ...
                ~strcmp(data_type, spec_data_type)
            warning("Specified data type does not match with the one specificated in file name, loaded data may not be correct");
        end
        fid = fopen(sanitized_file_location, "r");

        if strcmp(data_type, "c32") || strcmp(data_type, "c64")

            switch data_type
                case "c32"
                    cmplx_array = fread(fid, 'float');
                case "c64"
                    cmplx_array = fread(fid, 'double');
            end

            output = cmplx_array(1:2:end) + 1i * cmplx_array(2:2:end);

        else
            output = fread(fid, data_type);
        end

        fclose(fid);

        if ~iscolumn(output)
            output = output';
        end

    catch MExc
        error(MExc.identifier, "Exception caught: %s", MExc.message);
    end
end
