function hex_array = int2hex(int_value, digits)
    %INT2HEX Computes the hexadecimal representation of the given input integer value.
    %
    %   This function generates the hexadecimal representation of the given integer value, 
    %   columnwise and with the most significant symbol UP.
    %
    %   Input arguments:
    %     - int_value: Integer value to convert.
    %
    %     - digits: Minimum number of digits used to represent the input in binary format. If 
    %       specified input needs more bits to be represented in binary format, extra digits are 
    %       added.
    %
    %   Output arguments:
    %   
    %     - hex_array: Generated hexadecimal representation of the input value.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        int_value (1, 1) {mustBeNumeric, mustBeInteger}
        digits (1, 1) {mustBeNumeric, mustBeInteger} = 4
    end

    N = max(ceil(log(int_value) / log(16)), digits);

    hex_array = zeros(N, 1);

    for i = 0:N -1
        power = 16^(N -1 -i);
        hex_array(m_index(i)) = floor(mod(int_value, 16 * power) / power);
    end

    hex_array_indexes = hex_array < 10;
    hex_array(hex_array_indexes) = hex_array(hex_array_indexes) + 48;
    hex_array(not(hex_array_indexes)) = hex_array(not(hex_array_indexes)) + 55;

    hex_array = join(string(char(hex_array)), "");

end
