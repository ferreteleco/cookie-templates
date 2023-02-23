function int_numbers = bin2int(binary_input)
    %BIN2INT Computes the integers representation of the given binary input.
    %
    %   This functions considers a matrix where each integer is represented in a column vector (MSB 
    %   up) representing the input in its binary value.
    %
    %   Input arguments:
    % 
    %     - bin_array: Binary array to convert to its decimal representation.
    %
    %   Output arguments:
    % 
    %     - int_numbers: Integers representation of the input.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        binary_input (:, :) {mustBeMember(binary_input, [0, 1])}
    end

    tmp = flipud(binary_input);
    
    [rows, ~] = size(binary_input);
    tmp_2 = (2.^(0:rows - 1))';

    int_numbers = sum(tmp .* tmp_2, 1)';

end
