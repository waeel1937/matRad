
% 
% addpath(genpath('C:\matRad'));
% %first exsample 1 : 
% profile on;
% 
% % restoredefaultpath();
% runtests (pwd); 
%     
% %                             
% mocov('-cover',pwd,...
%         '-profile_info',... 
%         '-cover_xml_file','coverage.xml',...
%         '-cover_html_dir','coverage_html');
%     
%     
%     
% 
% profile off; 



%---------------------------------------------------------------------------------
tic



import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin

suite = TestSuite.fromPackage('optomization_tests_with_matlab_tests');


runner = TestRunner.withTextOutput;

runner.addPlugin(CodeCoveragePlugin.forFolder(['C:' filesep 'matRad' ...
    filesep 'matRad' filesep 'optimization' filesep '+DoseObjectives' ] ))
result = runner.run(suite);



toc


%---------------------------------------------------------------------------------


% 
% import matlab.unittest.TestRunner
% 
% testFile = 'matRad_interp1_test.m';
% suite = testsuite(testFile);
% runner = TestRunner.withTextOutput;
% 
% 
% import matlab.unittest.plugins.CodeCoveragePlugin
% import matlab.unittest.plugins.codecoverage.CoberturaFormat
% 
% sourceCodeFile = 'C:\matRad\matRad\matRad_interp1.m';
% reportFile = 'CoverageResults.xml';
% reportFormat = CoberturaFormat(reportFile);
% plugin = CodeCoveragePlugin.forFile(sourceCodeFile,'Producing',reportFormat);
% 
% runner.addPlugin(plugin);
% result = runner.run(suite);
% 
% disp(fileread(reportFile))

