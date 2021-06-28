function test_suite=test_matRad_DoseObjective
% tests for MOxUnitFunctionHandleTestCase

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    
    
    

function test_1


addpath(genpath('C:\matRad\matRad\optimization'));




%% Test : Abstract class Test


assertEqual(matRad_DoseObjective.name, []);
assertEqual(matRad_DoseObjective.parameterNames, []);
assertEqual(matRad_DoseObjective.parameterTypes, []);