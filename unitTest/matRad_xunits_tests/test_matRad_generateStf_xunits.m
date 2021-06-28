
function testSuite = test_matRad_generateStf_xunits
%testFunctionHandlesA Test file used by TestFunctionHandlesTest
%   Contains two passing tests.

%   Steven L. Eddins
%   Copyright 2008 The MathWorks, Inc.

localFunctionHandles = cellfun(@str2func, ...
  which('-subfun', mfilename('fullpath')), 'UniformOutput', false);
testSuite = buildFunctionHandleTestSuite(localFunctionHandles);



function test_1

    load TG119.mat
    matRad_rc

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


    assert(isequal([stf2.gantryAngle2], [stf1.gantryAngle]));
    assert(isequal([stf2.couchAngle2], [stf1.couchAngle]));
    assert(isequal([stf2.bixelWidth2], [stf1.bixelWidth]));
    assert(isequal([stf2.radiationMode2], [stf1.radiationMode]));
    %assert(isequal([stf2.isoCenter2], [stf1.isoCenter]));%false becouse it's double 
    assert(isequal([stf2.numOfRays2], [stf1.numOfRays]));
    assert(isequal([stf2.totalNumOfBixels2], [stf1.totalNumOfBixels]));




    stf1 = matRad_generateStf(ct,cst,pln);


    stf2 = struct('gantryAngle2', {struct('gantryAngles', num2cell(pln.propStf.gantryAngles)).gantryAngles} ...
        ,'couchAngle2',{struct('couchAngles', num2cell(pln.propStf.couchAngles)).couchAngles},'bixelWidth2',{20,20,20,20,20} ...
        ,'isoCenter2',{ pln.propStf.isoCenter(1,:) , pln.propStf.isoCenter(2,:)    , pln.propStf.isoCenter(3,:)     ...
        , pln.propStf.isoCenter(4,:), pln.propStf.isoCenter(5,:)} );


    assert(isequal([stf2.gantryAngle2], [stf1.gantryAngle]));
    assert(isequal([stf2.couchAngle2], [stf1.couchAngle]));
    assert(isequal([stf2.bixelWidth2], [stf1.bixelWidth]));
    assert(isequal([stf2.isoCenter2], [stf1.isoCenter]));



