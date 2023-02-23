function binary_output = int2bin(int_values, digits)
    %INT2BIN Computes the binary representation of the input integer values.
    %
    %   This function generates the binary representation of the given integer value, columnwise 
    %   and with the MSB UP.
    %
    %   Input arguments:
    % 
    %     - int_values: Integer values to convert.
    % 
    %     - digits: Minimum number of digits used to represent the input in binary format. If 
    %       specified input needs more bits to be represented in binary format, extra digits are 
    %       added. Defaults to 8 bits.
    %
    %   Output arguments:
    % 
    %     - hex_array: Generated binary representation of the input value.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        int_values (:, 1) {mustBeNumeric, mustBeInteger, mustBeNonnegative}
        digits (1, 1) {mustBeNumeric, mustBeInteger} = 8
    end

    N = max(ceil(log2(max(int_values))), digits);
    M = length(int_values);

    binary_output = zeros(N, M);

    for jj = 0 : M - 1
        for ii = 0:N - 1
            power = 2^(N -1 -ii);
            binary_output(m_index(ii), m_index(jj)) = ...
                floor(mod(int_values(m_index(jj)), 2 * power) / power);
        end
    end

end
