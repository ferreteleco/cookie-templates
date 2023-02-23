function hex_array = bin2hex(bin_array)
    %BIN2HEX Computes the hexadecimal representation of the given binary input.
    %
    %   This functions considers a Left MSB criteria and generates a column vector (most 
    %   significant symbol up) representing the input in its hexadecimal value.
    %
    %   Input arguments:
    % 
    %     - bin_array: Binary array to convert to its hexadecimal representation.
    %
    %   Output arguments:
    % 
    %     - hex_array: Hexadecimal representation of the input (uppercase).
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        bin_array (:, 1) {mustBeNumeric, mustBeInteger, ...
                        mustBeMember(bin_array, [0, 1])}
        end

        N = length(bin_array);
        M = ceil(N / 4);

        hex_array = char(ones(M, 1));

        if N > length(int2bin(flintmax))

            for i = 0:M -1
                tmp_int = bin2int(bin_array(m_index(0 + 4 * i):m_index(4 + 4 * i -1)));
                hex_array(m_index(i)) = int2hex(tmp_int, 1);
            end

        hex_array = join(string(hex_array), "");
        else
            int_number = bin2int(bin_array);
            hex_array = int2hex(int_number);
        end

end
