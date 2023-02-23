function output_data = read_bin_file_chunk(fid, chunk_size, data_type)
  %READ_BIN_FILE_CHUNK Read chunk_size elements (bytesize depending on data_type value) from a 
  % provided file identifier (fid).
  %
  %   They are not responsibility of this function to open nor closing the file where to obtain the
  %   data chunks. Also, this function assumes that no one modifies the position indicator for the
  %   file (no one is making reads in between function calls or, at least, the position indicator
  %   gets moved back after).
  %
  %   Input arguments:
  %
  %     - fid: Identifier for the file where to read data.
  % 
  %     - chunk_size: Number of elements to read. Note that the binary size that will be read 
  %       depends on the bytes per element that the type of the data has, and doubled for complex
  %       data (bytes_per_value*chunk_size or bytes_per_value*chunk_size*2 where bytes_per_value 
  %       depends on data_type).
  % 
  %     - data_type: Format of the binary data to read. Defaults to uint8.
  %
  %   Output arguments:
  %
  %     - output_data: Read data (size chunk_size elements) in the target data type.
  %
  % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
  %
  % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
  % Copyright (c) 2022 Andrés Ferreiro González

  
  arguments
    fid (1,1) double
    chunk_size (1,1) {mustBeInteger, mustBePositive}
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

  switch data_type
      case "uint16"
          bytes_per_value = 2;
      case "uint32"
          bytes_per_value = 4;
      case "uint64"
          bytes_per_value = 8;
      case "int8"
          bytes_per_value = 1;
      case "int16"
          bytes_per_value = 2;
      case "int32"
          bytes_per_value = 4;
      case "int64"
          bytes_per_value = 8;
      case "double"
          bytes_per_value = 8;
      case "c32"
          bytes_per_value = 4;
      case "c64"
          bytes_per_value = 8;
      otherwise
          bytes_per_value = 1;
  end

  try
    if strcmp(data_type, "c32") || strcmp(data_type, "c64")
        output_data_part = fread(fid, chunk_size*bytes_per_value*2, data_type);
        output_data = output_data_part(1:2:end) + 1i * output_data_part(2:2:end);
    else
        output_data = fread(fid, chunk_size*bytes_per_value, data_type);
    end
  catch ME
      ERR_STR = sprintf("%s:%s", ME.identifier, ME.message);
      LOG.fatal(mfilename, ERR_STR);
      rethrow(ME);
  end

end