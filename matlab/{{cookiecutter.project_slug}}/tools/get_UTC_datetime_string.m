function datetime_string = get_UTC_datetime_string()
    % GET_UTX_DATETIME_STRING Generates a string with the current datetime.
    %
    %   String format is yyyy_MM_dd_HH_mm_ss_SSSSSSSSS and timezone is UTC.
    %
    %   Output arguments:
    % 
    %     - datetime_string: String with formatted datetime (example: 
    %       2022_07_22_11_01_33_550201999).
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    datetime_string = string(datetime('now', ...
    'format', 'yyyy_MM_dd_HH_mm_ss_SSSSSSSSS', 'TimeZone', 'UTC'));
end
