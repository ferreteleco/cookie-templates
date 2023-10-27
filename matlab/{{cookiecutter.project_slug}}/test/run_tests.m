function run_tests(suite, NameValArgs)
    % run_tests Runs all available tests (or a single one, specified as input) and optionally
    % dumps the results to an xlsx file.
    %
    %   Note that automated tests discovery works for everything inside the unit directory, but
    %   any matlab's compatible test script or function (prepended by 'test_') can be manually
    %   specified as input and will be ran. Also, if the skip_test_scripts flag is deactivated
    %   (true by default), the test scripts (inside script folder) are included as well.
    %
    %   Input arguments:
    %
    %     - suite: List of names of the tests to execute. Test names correspond with the names of
    %       the files where they are defined. If empty ([]), all available tests are executed.
    %
    %   Tuple Arguments:
    %
    %     - xlsxReport: Flag that controls whether a custom format xlsx report of the test results
    %       shall be generated or not. Defaults to false.
    %
    %     - jUnitReport: Flag that controls whether a JUnit format test results report (XML) shall
    %       be generated or not. Defaults to false.
    %
    %     - htmlReport: Flag that controls whether a Matlab style test results report (HTML) shall
    %       be generated or not. Defaults to false.
    %
    %     - docxReport: Flag that controls whether a Matlab style test results report (DOCX) shall
    %       be generated or not. Defaults to false.
    %
    %     - pdfReport: Flag that controls whether a Matlab style test results report (PDF) shall
    %       be generated or not. Defaults to false.
    %
    %     - coberturaReport: Flag that controls whether a Cobertura format code coverage report
    %       (XML) shall be generated or not. Defaults to false.
    %
    %     - skipTestScripts: Flag that controls whether the test scripts shall be skipped from
    %       automatic test run or not. Defaults to true (skip them).
    %
    %     - resultsPath: Path where to store the different possible results reports. Defaults to
    %     "out".
    %
    %     - sourceCodeFolder: Base path where the source code resides. Defaults to "src".
    %
    %     - verbosity: This variable controls the verbosity of the output of the function:
    %       - 0: No information is displayed in the command window until end of test run.
    %       - 1: Test execution progress info is displayed in command window during the test run.
    %       - 2: Same as 1 plus test results are displayed in command window after end of test run.
    %       Defaults to 1.
    %
    % Author: Andrés Ferreiro González (aferreiro@gradiant.org)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Centro Tecnolóxico de Telecomunicacións de Galicia (GRADIANT)

    arguments
        suite (1, :) string = []
        NameValArgs.xlsxReport (1, 1) logical = false
        NameValArgs.jUnitReport (1, 1) logical = false
        NameValArgs.htmlReport (1, 1) logical = false
        NameValArgs.docxReport (1, 1) logical = false
        NameValArgs.pdfReport (1, 1) logical = false
        NameValArgs.coberturaReport (1, 1) logical = false
        NameValArgs.skipTestScripts (1, 1) logical = true
        NameValArgs.resultsPath (1, 1) string = ""
        NameValArgs.sourceCodeFolder (1, 1) string = "src"
        NameValArgs.verbosity (1,1) {mustBeMember(NameValArgs.verbosity, [0,1,2])} = 1
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Matlab routine timing procedure. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    t_start = tic;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    import matlab.unittest.TestRunner;
    import matlab.unittest.plugins.XMLPlugin;
    import matlab.unittest.plugins.CodeCoveragePlugin;
    import matlab.unittest.plugins.codecoverage.CoberturaFormat;
    import matlab.unittest.plugins.TestReportPlugin;

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

    if NameValArgs.verbosity == 0
        runner = TestRunner.withNoPlugins;
    else
        runner = TestRunner.withTextOutput;
    end

    if (NameValArgs.xlsxReport || NameValArgs.jUnitReport || NameValArgs.coberturaReport ||...
            NameValArgs.htmlReport || NameValArgs.docxReport || NameValArgs.pdfReport)

        if strcmp(NameValArgs.resultsPath, "")
            results_path = adapt_path_to_os("./out");
        else
            results_path = adapt_path_to_os(NameValArgs.resultsPath);
        end
        if isfolder(results_path) == 0
            mkdir(results_path)
        end
        results_filename_base = get_UTC_datetime_string();
    end

    if NameValArgs.jUnitReport
        xmlFile = sprintf("%s/%s_junit_report.%s", results_path, results_filename_base, "xml");
        p = XMLPlugin.producingJUnitFormat(xmlFile);
        runner.addPlugin(p);
    end

    if NameValArgs.htmlReport
        htmlBaseFolder = sprintf("%s/%s_html_report", results_path, results_filename_base);
        p = TestReportPlugin.producingHTML(htmlBaseFolder);
        runner.addPlugin(p);
    end

    if NameValArgs.docxReport
        docxFile = sprintf("%s/%s_report.%s", results_path, results_filename_base, "docx");
        p = TestReportPlugin.producingDOCX(docxFile);
        runner.addPlugin(p);
    end

    if NameValArgs.pdfReport
        pdfFile = sprintf("%s/%s_report.%s", results_path, results_filename_base, "pdf");
        p = TestReportPlugin.producingPDF(pdfFile);
        runner.addPlugin(p);
    end

    if NameValArgs.coberturaReport
        covFile = sprintf("%s/%s_cobertura_report.%s", results_path, results_filename_base, "xml");
        reportFormat = CoberturaFormat(covFile);
        srcFolder = adapt_path_to_os(NameValArgs.sourceCodeFolder);
        p = CodeCoveragePlugin.forFolder(srcFolder, ...
             "Producing", reportFormat, ...
             "IncludingSubfolders", true);
        runner.addPlugin(p);
    end

    if isempty(suite)
        all_tests = generate_tests_listing(NameValArgs.skipTestScripts);
    else
        all_tests = suite;
    end

    total_tests_number = length(all_tests);
    test_out = runner.run(testsuite(all_tests));

    failed_tests_names = [];
    failed_tests_number = 0;
    for jj = 1:length(test_out)
        if ~test_out(jj).Passed
            failed_tests_names = [failed_tests_names ; string(test_out(jj).Name)];
            failed_tests_number = failed_tests_number + 1;
        end
    end

    results_table = table(test_out);

    if (NameValArgs.xlsxReport)
        xlsxFilename = sprintf("%s/%s_results.%s", results_path, results_filename_base, "xlsx");

        updated_results_tables = process_results_table(results_table);
        for ii = 1 : length(updated_results_tables)
            table_values = updated_results_tables{ii};
            sheet_title = table_values(1, end).SuiteName;
            writetable( ...
            table_values(:, 1:end-2), ...
            xlsxFilename, 'Sheet', sheet_title);
        end
    end

    if NameValArgs.verbosity == 2
        disp(results_table);
    end

    if failed_tests_number > 0
        fprintf("\n\n");
        str = sprintf("Failed tests (%i out of %i):\n", failed_tests_number, total_tests_number);
        for ii = 1:length(failed_tests_names)
            str = strcat(str, sprintf("  - %s \n", failed_tests_names(ii)));
        end
        warning("FailedTests:list", str)
    else
        str = "All tests: Passed!";
        if exist("cprintf.m", "file") == 2
            cprintf("green", strcat(str, "\n"));
        else
            disp(str)
        end
    end

    clear global;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Matlab routine timing procedure. You can safely ignore it.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    t_end = toc(t_start);
    fprintf('\nrun_tests execution took %f s\n', t_end);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function all_tests = generate_tests_listing(skip_test_scripts)

    arguments
        skip_test_scripts (1, 1) logical
    end

    % - Impl. Notes (20220722-aferreiro) Re-implementation of automatic test suites
    % This code has been reimplemented in order to prevent matlab from changing current
    % working directory when automatically discovering tests, since that messed up a lot
    % with logging path configurations. Indexing is perfomed "matlab's way" since this will not
    % be ported to another language.

    if skip_test_scripts
        tests_listing = dir("test/unit/**/*.m");
    else
        tests_listing = dir("test/**/*.m");
    end

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

function splitted_tables = process_results_table(results_table)
    name_tokens = split(string(results_table.Name), '/');
    [~, cols] = size(name_tokens);
    if cols == 1
        name_tokens = name_tokens';
    end
    updated_table = results_table;
    updated_table.Name = name_tokens(:, 2);
    updated_table.SuiteName = erase(name_tokens(:, 1), "tests_");

    % Grouping by SuiteName, last table column (just added)
    suite_groups = findgroups(updated_table{:, end});

    % Split table based on first column - gender column
    splitted_table = splitapply( @(varargin) varargin, updated_table, suite_groups);

    % Allocate empty cell array fo size equal to number of rows in T_Split
    sub_tables = cell(size(splitted_table, 1), 1);

    % Create sub tables
    for ii = 1:size(splitted_table, 1)
        sub_tables{ii} = table(splitted_table{ii, :}, 'VariableNames', ...
        updated_table.Properties.VariableNames);
    end

    splitted_tables = sub_tables;

end
