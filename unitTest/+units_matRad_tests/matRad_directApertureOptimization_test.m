classdef matRad_directApertureOptimization_test  < matlab.unittest.TestCase
        
    methods (Test)

    %all and any 


        function test_1(testCase)
        
        load('TG119.mat'); 



            











        tic




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



        dij1 = matRad_calcPhotonDose(ct,stf1,pln,cst);


        dij2 = struct('numOfBeams2',{pln.propStf.numOfBeams  } ,'numOfScenarios2' ,{1},'numOfRaysPerBeam2',[25,20,25,25,20] ... 
            , 'totalNumOfBixels2' , {115}, 'totalNumOfRays2' , {115});


        testCase.assertEqual([dij2.numOfBeams2], [dij1.numOfBeams]);
        testCase.assertEqual([dij2.numOfScenarios2], [dij1.numOfScenarios]);
        testCase.assertEqual([dij2.numOfRaysPerBeam2], [dij1.numOfRaysPerBeam]);
        testCase.assertEqual([dij2.totalNumOfBixels2], [dij1.totalNumOfBixels]);
        testCase.assertEqual([dij2.totalNumOfRays2], [dij1.totalNumOfRays]);


        resultGUI1 = matRad_fluenceOptimization(dij1,cst,pln);

        resultGUI2 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([resultGUI2.status], [resultGUI1.info.status]);
        testCase.assertEqual([resultGUI2.iter], [resultGUI1.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern



        resultGUI12 = matRad_siochiLeafSequencing(resultGUI1,stf1,dij1,5);



        resultGUI22 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([resultGUI22.status], [resultGUI12.info.status]);
        testCase.assertEqual([resultGUI22.iter], [resultGUI12.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern





        optResult1 = matRad_directApertureOptimization(dij1,cst,resultGUI12.apertureInfo,resultGUI12,pln);



        optResult2 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([optResult2.status], [optResult1.info.status]);
        testCase.assertEqual([optResult2.iter], [optResult1.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern






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



        dij1 = matRad_calcPhotonDose(ct,stf1,pln,cst);


        dij2 = struct('numOfBeams2',{pln.propStf.numOfBeams  } ,'numOfScenarios2' ,{1},'numOfRaysPerBeam2',[25,20,25,25,20] ... 
            , 'totalNumOfBixels2' , {115}, 'totalNumOfRays2' , {115});


        testCase.assertEqual([dij2.numOfBeams2], [dij1.numOfBeams]);
        testCase.assertEqual([dij2.numOfScenarios2], [dij1.numOfScenarios]);
        testCase.assertEqual([dij2.numOfRaysPerBeam2], [dij1.numOfRaysPerBeam]);
        testCase.assertEqual([dij2.totalNumOfBixels2], [dij1.totalNumOfBixels]);
        testCase.assertEqual([dij2.totalNumOfRays2], [dij1.totalNumOfRays]);


        resultGUI1 = matRad_fluenceOptimization(dij1,cst,pln);

        resultGUI2 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([resultGUI2.status], [resultGUI1.info.status]);
        testCase.assertEqual([resultGUI2.iter], [resultGUI1.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern



        resultGUI12 = matRad_siochiLeafSequencing(resultGUI1,stf1,dij1,5);



        resultGUI22 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([resultGUI22.status], [resultGUI12.info.status]);
        testCase.assertEqual([resultGUI22.iter], [resultGUI12.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern





        optResult1 = matRad_directApertureOptimization(dij1,cst,resultGUI12.apertureInfo,resultGUI12,pln);



        optResult2 = struct('status',{1 } ,'iter' ,{26},'cpu',{1.186000000000000} ... 
            , 'objective' , {40.500382287044750});


        testCase.assertEqual([optResult2.status], [optResult1.info.status]);
        testCase.assertEqual([optResult2.iter], [optResult1.info.iter]);
        % testCase.assertEqual([resultGUI2.cpu], [resultGUI1.info.cpu]));%no compare for double > 3 ziffern
        % testCase.assertEqual([resultGUI2.objective], [resultGUI1.info.objective]));%no compare for double > 3 ziffern

        toc 
        end
        

        

    end
   
end
