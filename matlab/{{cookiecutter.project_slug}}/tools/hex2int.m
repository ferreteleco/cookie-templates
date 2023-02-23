function int_number = hex2int(hex_string)
    %HEX2INT Computes the integer representation of the given hexadecimal string.
    %
    %   This function generates the integer representation of the given hexadecimal string, 
    %   considering it's most significant symbol to be the left one.
    %
    %   Input arguments:
    % 
    %     - hex_string: Hexadecimal string to convert.
    %
    %   Output arguments:
    % 
    %     - int_number: Generated integer representation of the input value.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        hex_string (:, 1) string
    end

    tmp_1 = char(upper(hex_string))';
    tmp_1_indexes = tmp_1 < 65;
    tmp_1(tmp_1_indexes) = tmp_1(tmp_1_indexes) - 48;
    tmp_1(not(tmp_1_indexes)) = tmp_1(not(tmp_1_indexes)) - 55;
    tmp_1 = flipud(tmp_1) - 0;
    tmp_2 = (16.^(0:length(tmp_1) - 1))';

    int_number = sum(tmp_1 .* tmp_2);
end
