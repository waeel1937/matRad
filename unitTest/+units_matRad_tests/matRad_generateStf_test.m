

classdef matRad_generateStf_test  < matlab.unittest.TestCase
      
    methods (Test)

    %all and any 
        function testConstructor(testCase)
            matRad_cfg = MatRad_Config.instance();
            
           
            


            testCase.verifyEqual(matRad_cfg.keepLog, false);
            testCase.verifyEqual(matRad_cfg.writeLog, false);
        end
        
        function test_1(testCase)

            tic



            matRad_rc


            % 
        load TG119.mat

            pln.radiationMode   = 'photons';     % either photons / protons / carbon
            pln.machine         = 'Generic';

            pln.numOfFractions  = 30;

            % beam geometry settings
            pln.propStf.bixelWidth = 20 ;
            pln.propStf.gantryAngles    = [0:72:359]; % [?]
            pln.propStf.couchAngles     = [0 0 0 0 0]; % [?]
            pln.propStf.numOfBeams      = numel(pln.propStf.gantryAngles);
            pln.propStf.isoCenter       = ones(pln.propStf.numOfBeams,1) * matRad_getIsoCenter(cst,ct,0);

            % dose calculation settings
            pln.propDoseCalc.doseGrid.resolution.x = 5; % [mm]
            pln.propDoseCalc.doseGrid.resolution.y = 5; % [mm]
            pln.propDoseCalc.doseGrid.resolution.z = 5; % [mm]

            % optimization settings
            pln.propOpt.optimizer       = 'IPOPT';
            pln.propOpt.bioOptimization = 'none'; % none: physical optimization;             const_RBExD; constant RBE of 1.1;
                                                  % LEMIV_effect: effect-based optimization; LEMIV_RBExD: optimization of RBE-weighted dose
            pln.propOpt.runDAO          = false;  % 1/true: run DAO, 0/false: don't / will be ignored for particles
            pln.propOpt.runSequencing   = false;  % 1/true: run sequencing, 0/false: don't / will be ignored for particles and also triggered by runDAO below



            stf1 = matRad_generateStf(ct,cst,pln);
            stf2 = struct('gantryAngle2',{0,72,144,216,288},'couchAngle2',{0,0,0,0,0},'bixelWidth2',{20,20,20,20,20} ...
                ,'radiationMode2',{'photons','photons','photons','photons','photons'},'SAD2', {1000,1000,1000,1000,1000} ...
                ,'isoCenter2',{[251.308930008045,236.414722445696,162.642129257174],[251.308930008045,236.414722445696,162.642129257174] ...
                ,[251.308930008045,236.414722445696,162.642129257174],[251.308930008045,236.414722445696,162.642129257174],[251.308930008045,236.414722445696,162.642129257174]} ...
                , 'numOfRays2', {25 ,20, 25,25,20} , 'sourcePoint_bev2' ,  {[0,-1000,0],[0,-1000,0], [0,-1000,0], [0,-1000,0],[0,-1000,0] } ...
                , 'totalNumOfBixels2', {25,20,25,25,20} );


            testCase.assertEqual([stf2.gantryAngle2], [stf1.gantryAngle]);
            testCase.assertEqual([stf2.couchAngle2], [stf1.couchAngle]);
            testCase.assertEqual([stf2.bixelWidth2], [stf1.bixelWidth]);
            testCase.assertEqual([stf2.radiationMode2], [stf1.radiationMode]);
            %testCase.assertEqual([stf2.isoCenter2], [stf1.isoCenter]));%false becouse it's double 
            testCase.assertEqual([stf2.numOfRays2], [stf1.numOfRays]);
            testCase.assertEqual([stf2.totalNumOfBixels2], [stf1.totalNumOfBixels]);



            stf1 = matRad_generateStf(ct,cst,pln);


            stf2 = struct('gantryAngle2', {struct('gantryAngles', num2cell(pln.propStf.gantryAngles)).gantryAngles} ...
                ,'couchAngle2',{struct('couchAngles', num2cell(pln.propStf.couchAngles)).couchAngles},'bixelWidth2',{20,20,20,20,20} ...
                ,'isoCenter2',{ pln.propStf.isoCenter(1,:) , pln.propStf.isoCenter(2,:)    , pln.propStf.isoCenter(3,:)     ...
                , pln.propStf.isoCenter(4,:), pln.propStf.isoCenter(5,:)} );


            testCase.assertEqual([stf2.gantryAngle2], [stf1.gantryAngle]);
            testCase.assertEqual([stf2.couchAngle2], [stf1.couchAngle]);
            testCase.assertEqual([stf2.bixelWidth2], [stf1.bixelWidth]);
            testCase.assertEqual([stf2.isoCenter2], [stf1.isoCenter]);







            toc 

        end
        

        

    end
   
end
