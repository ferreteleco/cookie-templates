function [m_index] = m_index(cpp_index)
    %M_INDEX translates between a C/C++ index [0, N-1] to a matlab's one [1, N].
    %
    %   This function is useful to consider 0-based indexing, abstracting from matlab's 1-indexing
    %   feature.
    %
    %   Input arguments:
    %   
    %     - cpp_index: Index in C/C++ mode ([0, N-1])
    %
    %   Output arguments:
    % 
    %     - m_index: Equivalent matlab's index ([1, N])
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    m_index = cpp_index + 1;
end
