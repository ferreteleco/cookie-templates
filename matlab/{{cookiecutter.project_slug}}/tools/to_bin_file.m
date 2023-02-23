function to_bin_file(data, file_location, data_type)
    %TO_BIN_FILE Stores the input data in a binary vector using the specified data type (as column 
    % vector).
    %
    %   Note that if the parent folders of the file did not exist, this function do create them.
    %   Note that, if the specified file name does not terminate in a file extension, '.bin' is
    %   assumed for creation.
    % 
    %   Also, the specified data type gets inserted to the end of the filename, just before the
    %   file extension.
    %
    %   Input arguments:
    %     - data: data to be stored into file.
    % 
    %     - file_location: location of the file to be loaded into matlab.
    % 
    %     - data_type: format of the binary data to read. Defaults to uint8.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González


    arguments
        data (:, 1) {mustBeNumeric}
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

    sanitized_file_location = adapt_path_to_os(file_location);    
    [file_path, file_name, file_extension] = fileparts(sanitized_file_location);

    if strcmp(file_extension, "")
        WARN_MSG = "File extension not specified, assuming .bin";
        warning("ToBinFile:missingExtension", WARN_MSG);
        LOG.warn(mfilename, WARN_MSG);        
        file_extension = ".bin";       
    end
    
    LOG.debug(mfilename,'Appending data type to filename');
    sanitized_file_location = strcat(file_path, filesep(), file_name, "_", data_type, file_extension);

    if ~strcmp(file_path, "") && ~isfolder(file_path)
        mkdir(file_path)
    end

    try
        fid = fopen(sanitized_file_location, "w");

        if strcmp(data_type, "c32") || strcmp(data_type, "c64")

            vector_to_save = zeros(length(data) * 2, 1);
            vector_to_save(1:2:end) = real(data);
            vector_to_save(2:2:end) = imag(data);

            switch data_type
                case "c32"
                    ret = fwrite(fid, vector_to_save, 'float');
                case "c64"
                    ret = fwrite(fid, vector_to_save, 'double');
            end

        else

            ret = fwrite(fid, data, data_type);
        end

        fclose(fid);

        if ret < 0
            eid = 'File:WriteErr';
            msg = 'Write to file failed.';
            throwAsCaller(MException(eid, msg))
        end

    catch MExc
        error(MExc.identifier, "Exception caught: %s", MExc.message);
    end
end
