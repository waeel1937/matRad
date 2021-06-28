
classdef matRad_Config_test  < matlab.unittest.TestCase
      
    methods (Test)
        function testConstructor(testCase)
            matRad_cfg = MatRad_Config.instance();
            
           
            
%             testCase.verifyEqual(matRad_cfg.logLevel, 3); after set.log
%             have a new value 

            testCase.verifyEqual(matRad_cfg.keepLog, false);
            testCase.verifyEqual(matRad_cfg.writeLog, false);
        end
        
        function testResetMatRad_cfg(testCase)
            
            matRad_cfg = MatRad_Config.instance();
            
            
            matRad_cfg.reset();
            
            testCase.verifyEqual(matRad_cfg.propStf.defaultLongitudinalSpotSpacing, 2);
            testCase.verifyEqual(matRad_cfg.propStf.defaultAddMargin, true);
            testCase.verifyEqual(matRad_cfg.disableGUI, false);
            testCase.verifyEqual(matRad_cfg.propOpt.defaultMaxIter, 500);
            testCase.verifyEqual(matRad_cfg.propMC.ompMC_defaultHistories, 1e6);
            testCase.verifyEqual(matRad_cfg.propStf.defaultLongitudinalSpotSpacing, 2);
            testCase.verifyEqual(matRad_cfg.propMC.ompMC_defaultOutputVariance, false);
            testCase.verifyEqual(matRad_cfg.propMC.MCsquare_defaultHistories, 1e6);
            testCase.verifyEqual(matRad_cfg.propMC.direct_defaultHistories, 2e4);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultResolution, struct('x',3,'y',3,'z',3));
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultLateralCutOff, 0.995);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultGeometricCutOff, 50);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultSsdDensityThreshold, 0.05);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultUseGivenEqDensityCube, false);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultIgnoreOutsideDensities, true);
            testCase.verifyEqual(matRad_cfg.propDoseCalc.defaultUseCustomPrimaryPhotonFluence, false);
            
        end
        
        function testDispError(testCase)
            
            import matlab.unittest.constraints.Throws;
            matRad_cfg = MatRad_Config.instance();
            
            testCase.verifyThat(@()matRad_cfg.dispError('Invalid bixel width! Must be a scalar number or ''field'' for field-based dose calculation with shapes stored in stf!'),Throws('matRad:Error'));
            testCase.verifyWarning(@()matRad_cfg.dispWarning('stf and pln are not consistent, using pln for geometry display!'),'');
     
        end
        
        function testDispWarning(testCase)
            import matlab.unittest.constraints.IssuesWarnings;
            matRad_cfg = MatRad_Config.instance();

            testCase.verifyWarning(@()matRad_cfg.dispWarning('stf and pln are not consistent, using pln for geometry display!'),'');
     
        end
        
        function testSetLogLevel(testCase)
            
            matRad_cfg = MatRad_Config.instance();
            

            newLogLevel  = 3;
            
            matRad_cfg.logLevel = newLogLevel;

            testCase.verifyEqual(matRad_cfg.logLevel, newLogLevel);
            
            newLogLevel  = 4;
            
            matRad_cfg.logLevel = newLogLevel;
            
            testCase.verifyEqual(matRad_cfg.logLevel, newLogLevel);
            
%             newLogLevel  = 6;
%             matRad_cfg.logLevel = newLogLevel;
%             testCase.verifyEqual(matRad_cfg.logLevel, newLogLevel); Error 'Invalid log level. Value must be between 1 and 5'
            
        end
        

    end
   
end

 

