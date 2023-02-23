%-------------------------------------------------------------------------
% Andrés Ferreiro González
% andres.ferreiro.glez@gmail.com
% 11/07/22
% Matlab Version: 9.10.0.1851785 (R2021a) Update 6
%-------------------------------------------------------------------------
% This script uses m2html utility to generate project's documentation.
%-------------------------------------------------------------------------


HTML_DIRECTORY = 'docs';
RECURSIVE = 'on';
DOWNLOAD = 'on';
HYPERTEXT = 'on';
GEN_TODOS = 'on';
DEP_GRAPH = 'on';
IGNORED = {};

m2html('mFiles', 'src', 'htmldir', HTML_DIRECTORY, ...
    'recursive', RECURSIVE, ...
    'download', DOWNLOAD, ...
    'globalHypertextLinks', HYPERTEXT, ...
    'todo', GEN_TODOS, ...
    'ignoredDir', IGNORED, ...
    'graph', DEP_GRAPH, ...
    'template', 'blue' ...
    );
