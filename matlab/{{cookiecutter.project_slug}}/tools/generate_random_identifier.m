function id = generate_random_identifier(n_chars)
    %GENERATE_RANDOM_IDENTIFIER Generates a random string of specified length, that can be used to
    % identify different components in the projects.
    %
    %   Input arguments:
    %     
    %     - n_chars: Number of characters used to generate the identifier. Must be between 3 and 16,
    %       both included. Defaults to 5.
    %
    %   Output arguments:
    %
    %     - id: Generated identifier.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        n_chars(1, 1) {mustBeInteger, ...
         mustBeGreaterThan(n_chars, 2), mustBeLessThan(n_chars, 17)} = 5
    end

    id = string(char(randi([65 90], 1, n_chars)));
end
