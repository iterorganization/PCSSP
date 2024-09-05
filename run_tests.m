function results = run_tests()

% main script to initialize PCSSP and run all tests in batch

import matlab.unittest.TestRunner
import matlab.unittest.TestSuite
import matlab.unittest.plugins.XMLPlugin
import matlab.unittest.plugins.TestReportPlugin
import matlab.unittest.plugins.CodeCoveragePlugin

% use testSuite method to build suite from Folder, selecting only those
% tests that have pcssp_test as superclass. More options here:
% https://nl.mathworks.com/help/matlab/ref/matlab.unittest.testsuite-class.html

pcssp_add_paths();

% add platform specific path to large test input data
test_data_path = getenv("TEST_DATA_PATH");

if ~isempty(test_data_path)
   addpath(genpath(test_data_path));     
end


suite = TestSuite.fromFolder(pwd,'IncludingSubfolders',true,'Superclass',{'pcssp_module_test','pcssp_wrapper_test','pcssp_topmodel_test'});

runner = TestRunner.withNoPlugins;

% add JUnit xml-writer plug-in to test
xmlFile = 'testResults.xml';
p = XMLPlugin.producingJUnitFormat(xmlFile);

% add html test report to suite
htmlFile = "testreport";
p1 = TestReportPlugin.producingHTML(htmlFile);

% add code coverage for pcssp
reportFormat = matlab.unittest.plugins.codecoverage.CoverageReport("coverageReportPCSSP");

% add m-files in repo, excluding scdds
dirOut = dir('**/*.m');

codeFilepaths = string({dirOut.folder}) + filesep + string({dirOut.name});

filePathsToExclude = fullfile(fileparts(mfilename('fullpath')),'scdds-core');
codeFilepaths(contains(codeFilepaths, filePathsToExclude)) = [];
p2 = matlab.unittest.plugins.CodeCoveragePlugin.forFile(codeFilepaths,'Producing',reportFormat);

% run the tests
runner.addPlugin(p)
runner.addPlugin(p1)
runner.addPlugin(p2)
results = runner.run(suite);
end



