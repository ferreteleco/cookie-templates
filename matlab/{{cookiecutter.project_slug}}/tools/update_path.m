function update_path(folders_list, NameValArgs)
    %UPDATE_PATH Updates the path by adding / removing the specified folders to/from Matlab's path.
    %
    %   This function adds / removes the specified folders (and optionally, its sub-folders) to / 
    %   from Matlab's path for current execution.
    % 
    %   If a global Log4M LOG variable has been defined, it uses it. Otherwise, it creates a default
    %   logging object in ./logs (and fails if the folder not exists).
    %
    %   Input arguments:
    % 
    %     - folders_list: Array of strings specifying paths to be added (might be relative).
    % 
    %   Tuple arguments:
    %   
    %     - action: Action to perform, add or substract folders from path ("add", "remove"). 
    %       Defaults to "add".
    % 
    %     - recursive: Whether to add sub-folders to path or not. Defaults to false.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        folders_list (1, :) string
        NameValArgs.action (1, 1) string {mustBeMember(NameValArgs.action, ...
                                        {'add', 'remove'})} = "add"
        NameValArgs.recursive logical = false
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

    try

        LOG.debug(mfilename, ...
            sprintf("Updating %d file roots in path (subdirectories_included=%d)", ...
            length(folders_list), NameValArgs.recursive));

        for jj = 1:length(folders_list)

            if NameValArgs.recursive
                items = genpath(folders_list(jj));
            else
                items = folders_list(jj) + ";";
            end

            if strcmp("add", NameValArgs.action)
                addpath(items);
            else
                rmpath(items);
            end

            tmp = strsplit(items, ';');

            for ii = 1:numel(tmp) - 1
                LOG.debug(mfilename, sprintf(' Just updated %s', tmp{ii}));
            end

        end

        LOG.info(mfilename, ...
            sprintf("Updated %d files to path (%d folders with %d sub-folders inside)", ...
            numel(tmp) - 1, length(folders_list), numel(tmp) - 1 - length(folders_list)));

        clear("items", "ii", "jj", "tmp")

    catch err
        LOG.error(mfilename, " There are some problems with generated path, for more info see references present in function description.");
        error("updtPath:incorrectGeneration", 'There are some problems with generated path, for more info see references present in function description.');
    end

end
