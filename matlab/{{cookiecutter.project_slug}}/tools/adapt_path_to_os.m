function path_os = adapt_path_to_os(path)
    %ADAPT_PATH_TO_OS Adapts a given path to a specific OS (Windows / Linux).
    % 
    % Note that this function also resolves relative paths to absolute ones.
    %
    %   Input arguments:
    % 
    %     - PATH: Input path
    %
    %   Output arguments:
    % 
    %     - path_os: Input path adapted to current OS (Windows / Linux)
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    % Project: {{ cookiecutter.project_name }}
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        path (1, 1) string
    end  

    if strcmp(path, ".")
        path_os = pwd;
    else
        
        full_file_flag = false;

        if ispc
            
            path_os = replace(path, "/", "\");
            OS_WINDOWS_DRIVE_PATTERN = lettersPattern(1);         
            if startsWith(path_os, OS_WINDOWS_DRIVE_PATTERN)
                full_file_flag =  true;
            end
            
        elseif isunix
            
            path_os = replace(path, "\", "/");
            path_os = replace(path_os, "//", "/");
            
            if startsWith(path_os, "/")
                full_file_flag =  true;
            end
        end

        if ~full_file_flag
            path_os = fullfile(pwd, path_os);
        end
    end
end
