function [num, rat, loc] = biterr(a, b)
    %BITERR Compute number of bit errors and bit error rate over two binary inputs.
    %
    %   Overrides Matlab's Communication Toolbox "biterr" function.
    %
    %   Input arguments:
    %
    %     - a: First input vector.
    %
    %     - b: Second input vector.
    %
    %   Output arguments:
    %
    %     - number: Number of different bits.
    %
    %     - rat: Ratio of errors (current / possible).
    %
    %     - loc: Individual location of the errors.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        a (:, 1) {mustBeMember(a, [0, 1])}
        b (:, 1) {mustBeMember(b, [0, 1])}
    end

    N = length(a);
    loc = double(a ~= b);
    rat = 0;

    num = sum(loc);

    if any(loc) && nargout > 1
        rat = sum(loc) / N;
    end

end
