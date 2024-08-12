function results = run_tests()

% main script to initialize PCSSP and run all tests in batch

import matlab.unittest.TestRunner
import matlab.unittest.TestSuite
import matlab.unittest.plugins.XMLPlugin
import matlab.unittest.plugins.TestReportPlugin
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport

% use testSuite method to build suite from Folder, selecting only those
% tests that have pcssp_test as superclass. More options here:
% https://nl.mathworks.com/help/matlab/ref/matlab.unittest.testsuite-class.html

pcssp_add_paths();

suite = TestSuite.fromFolder(pwd,'IncludingSubfolders',true,'Superclass',{'pcssp_module_test','pcssp_topmodel_test'});

runner = TestRunner.withNoPlugins;

% add JUnit xml-writer plug-in to test
xmlFile = 'testResults.xml';
p = XMLPlugin.producingJUnitFormat(xmlFile);

% add html test report to suite
htmlFile = "testreport";
p1 = TestReportPlugin.producingHTML(htmlFile);

% add code coverage for pcssp
reportFormat = CoverageReport("coverageReportPCSSP");

% add m-files in repo, excluding scdds
files = get_files_for_coverage_test();
p2 = matlab.unittest.plugins.CodeCoveragePlugin.forFile(files,'Producing',reportFormat);

% run the tests
runner.addPlugin(p)
runner.addPlugin(p1)
runner.addPlugin(p2)
results = runner.run(suite);
end


function files = get_files_for_coverage_test()

f = dir('**/*.m'); % all .m in the pcssp repository

f(contains({f(:).folder},'scdds-core')) = []; % remove SCDDS-core


files  = [""];

for ii = 1:numel(f)  
files(ii) = fullfile({f(ii).folder},{f(ii).name});
end

end