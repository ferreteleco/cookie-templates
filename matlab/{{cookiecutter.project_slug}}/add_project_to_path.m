%-------------------------------------------------------------------------
% Andrés Ferreiro González
% andres.ferreiro.glez@gmail.com
% 11/07/22
% Matlab Version: 9.10.0.1851785 (R2021a) Update 6
%-------------------------------------------------------------------------
% This script adds the 'src', 'test' and 'tools' directories to Matlab's path.
%-------------------------------------------------------------------------

addpath("tools");
update_path(["src", "test", "scripts"], "recursive", true);
