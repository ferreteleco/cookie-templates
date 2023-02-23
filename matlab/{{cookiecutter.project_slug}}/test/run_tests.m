function run_tests(suite, save_to_xlsx, NameValArgs)
    % run_tests Runs all available tests (or a single one, specified as input) and optionally
    % dumps the results to an xlsx file.
    %
    % Input arguments:
    %   - suite: Name of the tests to execute. If empty ([]), all available tests are executed.
    %   - save_to_xlsx: Flag that controls whether output should be stored in xlsx format or not.
    %
    % Tuple Arguments:
    %   - results_path: Path where to store the xlsx results (no extension needed). Defaults to
    %   logs/test_results.xslx.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    arguments
        suite (1, :) string = []
        save_to_xlsx (1, 1) logical = false
        NameValArgs.results_path (1, 1) string = "./logs/test_results"
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MATLAB's logging (log4m) utility code. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global LOG;
    if isempty(LOG) || isfield(LOG, "dummy")
        LOG = struct('trace', @(varargin) 1, 'debug', @(varargin) 1, 'info', ...
        @(varargin) 1, 'warn', @(varargin) 1, 'timing', @(varargin) 1, ...
            'error', @(varargin) 1, 'fatal', @(varargin) 1, 'dummy', true);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if save_to_xlsx && ~strcmp(NameValArgs.results_path, '')
        full_path = adapt_path_to_os(NameValArgs.results_path);
        base_log_dir = fileparts(full_path);
        if isfolder(base_log_dir) == 0
            mkdir(base_log_dir)
        end
    end

    if isempty(suite)
        all_tests = generate_tests_listing();
    else
        all_tests = suite;
    end

    for ii = 1 : length(all_tests)
        test_out = runtests(all_tests(ii));
        if (save_to_xlsx)
            updated_table = table(test_out);
            name_tokens = split(string(updated_table.Name), '/');
            [~, cols] = size(name_tokens);
                if cols == 1
                    name_tokens = name_tokens';
                end
            updated_table.Name = name_tokens(:, 2);
            writetable( ...
            updated_table, ...
            adapt_path_to_os(NameValArgs.results_path + ".xlsx"), 'Sheet', all_tests(ii));
        end
    end
    clear global;
end

function all_tests = generate_tests_listing()

    % - Impl. Notes (20220722-aferreiro) Re-implementation of automatic test suites
    % This code has been reimplemented in order to prevent matlab from changing current
    % working directory when automatically discovering tests, since that messed up a lot
    % with logging path configurations. Indexing is perfomed "matlab's way" since this will not
    % be ported to another language.

    tests_listing = dir("test/**/*.m");
    M = length(tests_listing);
    all_tests = string(zeros(M - 1, 1));
    test_index = 1;

    for ii = 1:M

        if ~strcmp(tests_listing(ii).name, "run_tests.m")
            all_tests(test_index) = replace(string(tests_listing(ii).name), ".m", "");
            test_index = test_index +1;
        end
    end
end
