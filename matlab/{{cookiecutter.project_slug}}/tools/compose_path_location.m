function composed_path = compose_path_location(base_path, file_name_base, component_identifier, ...
    ext, exec_date)
    % COMPOSE_PATH_LOCATION Generates a full path name given the different information relative to 
    % a file to be created.
    %
    %   Input arguments:
    %     
    %     - base_path: Base path (folder) in which to store the file.
    % 
    %     - file_name_base: Base name for the file.
    % 
    %     - component_identifier: String identifying the component (useful when using more than one 
    %       instance of the same component in the same execution).
    % 
    %     - ext: File extension. Defaults to "bin".
    % 
    %     - exec_date: String representing the execution date to be stored.
    % 
    %   Output arguments:
    % 
    %     - composed_path: Generated full path to the file (date - file_name_base - 
    %       component_identifier).
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        base_path (1, 1) string
        file_name_base (1, 1) string
        component_identifier (1, 1) string = ""
        ext (1, 1) string = "bin"
        exec_date (1, 1) string = ""
    end

    if (strcmp(component_identifier, ""))
        composed_file_name = file_name_base;
    else
        composed_file_name = sprintf("%s_%s", file_name_base, component_identifier);
    end

    sanitized_ext = strrep(ext, ".", "");

    if (strcmp(exec_date, ""))
        composed_file_name = sprintf("%s.%s", composed_file_name, sanitized_ext);
    else
        composed_file_name = sprintf("%s_%s.%s", exec_date, composed_file_name, sanitized_ext);
    end

    sanitized_path = adapt_path_to_os(base_path);

    composed_path = strcat(sanitized_path, filesep(), composed_file_name);

end
