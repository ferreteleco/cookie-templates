classdef BaseClass < handle
    % BASECLASS Defines the base components of the other classes of this project.
    %
    %   This class holds the configuration for the logging in the child classes (through log4m)
    %   and the ability  to dump generated outputs to a binary file (with proper format in each
    %   case). Moreover, it allows to define an identifier for each generated instance (which
    %   should be unique).
    %
    %   Attributes:
    %
    %     - LOG: This attribute holds the logger object (if defined) or a proper sink to get rid of
    %       logging entries.
    %
    %     - dump_files_path: This attribute holds the relative or absolute path location where to
    %       store the result of the inherited object's internal processes. Note that a descriptor
    %       of the module dumping the data, its identifier, the execution date and the data format
    %       (uint8, c64, double...) are inserted in the generated filenames to be stored in order
    %       to differentiate between continuous executions. If a void path ("") is specified,
    %       data dumping is disabled.
    %
    %     - component_identifier: This attribute holds the string identifying the component (useful
    %       when using more than one instance of the same component in the same execution).
    %       Defaults to a random set of letters (A-Z, size 5).
    %
    %     - SAVE_FORMAT: Format in which to dump the generated data.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    properties (SetAccess = private)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Common attributes (logging, path where to dump files and object ID string)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        LOG;
        dump_files_path;
        component_identifier;
        SAVE_FORMAT;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end

    methods

        function obj = BaseClass(component_identifier, dump_files_path, SAVE_FORMAT)
            % BASECLASS Constructs a new instance of this class.
            %
            %   Input arguments:
            %
            %     - component_identifier: String identifying the component (useful when using more
            %       than one instance of the same component in the same execution). Defaults to a
            %       random set of letters (A-Z, size 5).
            %
            %     - dump_files_path: Relative or absolute path location where to  store the result
            %       of the inherited object's internal processes. Note that a descriptor of the
            %       module dumping the data, its identifier, the execution date and the data format
            %       (uint8, c64, double...) appended to the generated filenames in the specified
            %       folder in order to differentiate between continuous executions. If a void path
            %       ("") is specified, data dumping is disabled.
            %
            %     - SAVE_FORMAT: Format in which to dump the generated data.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                component_identifier (1, 1) string = generate_random_identifier(5)
                dump_files_path (1, 1) string = ""
                SAVE_FORMAT (1, 1) string = "c64"
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

            obj.LOG = LOG;

            if strcmp(component_identifier, "")
                id = generate_random_identifier(5);
            else
                id = upper(component_identifier);
            end

            obj.component_identifier = id;

            if ~strcmp(dump_files_path, "")
                obj.dump_files_path = adapt_path_to_os(dump_files_path);
            else
                obj.dump_files_path = dump_files_path;
            end

            obj.SAVE_FORMAT = SAVE_FORMAT;
        end

        function update_dump_files_path(obj, dump_files_path)
            % UPDATE_DEBUG_FILES_PATH Updates the folder path where to store the results of the
            % child object's promethod calls.
            %
            %   Input arguments:
            %
            %     - dump_files_path: Relative or absolute path location where to  store the result
            %       of the child object's own processes. Note that a descriptor of the module
            %       dumping the data, its identifier and the execution date gets inserted to the
            %       filename in order to differentiate between continuous executions. If a void
            %       path ("") is specified, data dumping is disabled.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) BaseClass
                dump_files_path (1, 1) string
            end

            obj.LOG.debug(mfilename, ...
                sprintf( ...
                "Updating Dump Files Path for component (%s) as requested", ...
                obj.component_identifier));

            if strcmp(dump_files_path, "")
                obj.LOG.info(mfilename, "Disabling dump mode...");
                obj.dump_files_path = "";
            else
                obj.dump_files_path = adapt_path_to_os(dump_files_path);
            end

        end

        function update_save_format(obj, save_format)
            % UPDATE_SAVE_FORMAT Updates the file format with which to save the results of the
            % child object's method calls.
            %
            %   Input arguments:
            %
            %     - save_format: Format in which to dump the generated data.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) BaseClass
                save_format (1, 1) string
            end

            obj.LOG.debug(mfilename, ...
                sprintf( ...
                "Updating SAVE_FORMAT for component (%s) as requested", ...
                obj.component_identifier));

            if strcmp(save_format, "")
                MSG_STR = "New save_format cannot be emtpy string";
                obj.LOG.error(mfilename, MSG_STR);
                error("BaseClass:InvalidSaveFormat", MSG_STR);
            else
                obj.SAVE_FORMAT = save_format;
            end

        end

    end

end
