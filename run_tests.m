function results = run_tests()

% main script to initialize PCSSP and run all tests in batch

% setup paths
run pcssp_add_paths;


import matlab.unittest.TestRunner
import matlab.unittest.TestSuite
import matlab.unittest.plugins.XMLPlugin
import matlab.unittest.plugins.TestReportPlugin



% use testSuite method to build suite from Class. Other options here;
% https://nl.mathworks.com/help/matlab/ref/matlab.unittest.testsuite-class.html


suite = TestSuite.fromFolder(pwd,'IncludingSubfolders',true,'Superclass','pcssp_test');



runner = TestRunner.withNoPlugins;

% add JUnit xml-writer plug-in to test
xmlFile = 'testResults.xml';
p = XMLPlugin.producingJUnitFormat(xmlFile);

% add html test report to suite
htmlFile = "testreport";
p1 = TestReportPlugin.producingHTML(htmlFile);

% run the tests
runner.addPlugin(p)
runner.addPlugin(p1)
results = runner.run(suite);
end
