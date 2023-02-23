function bin_array = hex2bin(hex_string)
    %HEX2INT Computes the binary representation of the given hexadecimal string.
    %
    %   This function generates the binary representation of the given hexadecimal string, 
    %   considering it's most significant symbol to be the left one. The generated binary vector is 
    %   defined columnwise with it's MSB up.
    %
    %   Input arguments:
    % 
    %     - hex_string: Hexadecimal string to convert.
    %
    %   Output arguments:
    % 
    %     - bin_array: Generated binary representation of the input value.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        hex_string (:, 1) string
    end

    N = strlength(hex_string);

    bin_array = zeros(N * 4, 1);

    if N > strlength(int2hex(flintmax))
        chr_vector = char(hex_string);

        for i = 0:N - 1
            tmp_int = hex2int(chr_vector(m_index(i)));
            bin_array(m_index(0 + 4 * i):m_index(4 + 4 * i -1)) = int2bin(tmp_int, 4);
        end

    else
        int_number = hex2int(hex_string);
        bin_array = int2bin(int_number);
    end
end
