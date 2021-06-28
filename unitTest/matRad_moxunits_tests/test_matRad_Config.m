function test_suite= test_matRad_Config
% tests for MOxUnitFunctionHandleTestCase


    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    
    
    
function test_1
    
    
    
	matRad_cfg = MatRad_Config.instance();


    matRad_cfg.reset();

    assertEqual(matRad_cfg.propStf.defaultLongitudinalSpotSpacing, 2);
    assertEqual(matRad_cfg.propStf.defaultAddMargin, true);
    assertEqual(matRad_cfg.disableGUI, false);
    assertEqual(matRad_cfg.propOpt.defaultMaxIter, 500);
    assertEqual(matRad_cfg.propMC.ompMC_defaultHistories, 1e6);
    assertEqual(matRad_cfg.propStf.defaultLongitudinalSpotSpacing, 2);
    assertEqual(matRad_cfg.propMC.ompMC_defaultOutputVariance, false);
    assertEqual(matRad_cfg.propMC.MCsquare_defaultHistories, 1e6);
    assertEqual(matRad_cfg.propMC.direct_defaultHistories, 2e4);
    assertEqual(matRad_cfg.propDoseCalc.defaultResolution, struct('x',3,'y',3,'z',3));
    assertEqual(matRad_cfg.propDoseCalc.defaultLateralCutOff, 0.995);
    assertEqual(matRad_cfg.propDoseCalc.defaultGeometricCutOff, 50);
    assertEqual(matRad_cfg.propDoseCalc.defaultSsdDensityThreshold, 0.05);
    assertEqual(matRad_cfg.propDoseCalc.defaultUseGivenEqDensityCube, false);
    assertEqual(matRad_cfg.propDoseCalc.defaultIgnoreOutsideDensities, true);
    assertEqual(matRad_cfg.propDoseCalc.defaultUseCustomPrimaryPhotonFluence, false);
%     import matlab.unittest.constraints.Throws;
%     matRad_cfg = MatRad_Config.instance();

%     verifyThat(@()matRad_cfg.dispError('Invalid bixel width! Must be a scalar number or ''field'' for field-based dose calculation with shapes stored in stf!'),Throws('matRad:Error'));
%      verifyWarning(@()matRad_cfg.dispWarning('stf and pln are not consistent, using pln for geometry display!'),'');
    matRad_cfg = MatRad_Config.instance();



%              assertEqual(matRad_cfg.logLevel, 3); after set.log
%             have a new value 

     assertEqual(matRad_cfg.keepLog, false);
     assertEqual(matRad_cfg.writeLog, false);
    
%     import matlab.unittest.constraints.IssuesWarnings;
    matRad_cfg = MatRad_Config.instance();

    assertWarning(@()matRad_cfg.dispWarning('stf and pln are not consistent, using pln for geometry display!'),'');

    matRad_cfg = MatRad_Config.instance();


    newLogLevel  = 3;

    matRad_cfg.logLevel = newLogLevel;

     assertEqual(matRad_cfg.logLevel, newLogLevel);

    newLogLevel  = 4;

    matRad_cfg.logLevel = newLogLevel;

     assertEqual(matRad_cfg.logLevel, newLogLevel);

%             newLogLevel  = 6;
%             matRad_cfg.logLevel = newLogLevel;
%              assertEqual(matRad_cfg.logLevel, newLogLevel); Error 'Invalid log level. Value must be between 1 and 5'


 

