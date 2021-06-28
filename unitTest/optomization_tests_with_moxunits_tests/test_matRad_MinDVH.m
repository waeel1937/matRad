



function test_suite=test_matRad_MinDVH
% tests for MOxUnitFunctionHandleTestCase

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    
    
    

function test_1





addpath(genpath('C:\matRad\matRad\optimization'));

import DoseObjectives.matRad_MinDVH

%% Test 1: Quadratische Abweichung
dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

scal  = {60,95} ; 

r  =  matRad_MinDVH(dos,scal);


assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 60);
assertEqual(r.parameters{2}, 95);
assertEqual(r.penalty,dos);


%% Test 2: Quadratische Abweichung
dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

scal  = 2 ; 

r  =  matRad_MinDVH(dos,scal);


assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 3: Quadratische Abweichung
dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

scal  = 42 ; 

r  =  matRad_MinDVH(dos,42);



assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);


%% Test 4: Quadratische Abweichung
dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

scal  = 2 ; 

r  =  matRad_MinDVH(dos,scal);



assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 5: Quadratische Abweichung


dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

r  =  matRad_MinDVH(dos);


assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 60);
assertEqual(r.penalty,1);

%% Test 6 : Quadratische Abweichung & Dose Objective Function berechnen


dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};



r  =  matRad_MinDVH(dos);


assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 60);
assertEqual(r.penalty,1);

sbioloadproject('AntibacterialPKPD')
em = export(m1);
doses = r.parameters{1};

r1  =  computeDoseObjectiveFunction(r,doses);

assertEqual(r1,0);

r2  = computeDoseObjectiveGradient(r,doses);

assertEqual(r2,0);

%% Test 7: Test the Gradient

dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

scal  = {60,95} ; 

r  =  matRad_MinDVH(dos,scal);


assertEqual(r.name, 'Min DVH');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal{1});
assertEqual(r.parameters{2}, scal{2});
assertEqual(r.penalty,dos);

dos.name = 'Min DVH';
dos.parameterNames = {'d', 'V^{min}'};
dos.parameterTypes = {'dose','numeric'};

r  =  matRad_MinDVH(dos);

dos_ = r.parameters{2} -  r.parameters{1} ;

grad_ObjectiveGradient  = r.computeDoseObjectiveGradient(dos_);

% test the gradient with gradient()
grad_gradient = gradient([r.parameters{1} dos_ ]) ;

resultat_of_grad1 =grad_gradient(1)* 2;

% test the gradient with gradient()
x = sym('x');
grad_jacobian = jacobian((dos_*x - r.parameters{1}*x)*2 , [x]) ;

assertEqual(resultat_of_grad1,double(grad_jacobian));
assertEqual(grad_ObjectiveGradient,double(grad_jacobian));% Error becose underdose(underdose>0) = 0; by > 0  = 0 
assertEqual(resultat_of_grad1,grad_ObjectiveGradient);% Error becose underdose(underdose>0) = 0; by > 0  = 0 




    %% Test 4: Test the Interfaces 
   
    
    dos.name = 'Squared Overdosing';
    dos.parameterNames = {'d^{max}'};
    dos.parameterTypes = {'dose'};

    scal  = makedist('Normal') ; 


    r  =  matRad_SquaredOverdosing(dos);
    dos_ = [ 1 2 3 4 ];

    grad_Objective  = r.computeDoseObjectiveGradient(dos_);
    fun_Objective = r.computeDoseObjectiveFunction(dos_);
    
    isscalar(grad_Objective);
    isscalar(fun_Objective);
    
    assertEqual(fun_Objective,zeros(length(dos_),length(dos_)));
    
    dos_ = [ 10 10 ];
    grad_Objective  = r.computeDoseObjectiveGradient(dos_);
    fun_Objective = r.computeDoseObjectiveFunction(dos_);
    
   
    
    isscalar(grad_ObjectiveGradient);
    isscalar(fun_Objective);

    assertEqual(fun_Objective,zeros(length(dos_),length(dos_)))

    
    
    dos_ = [ 1 3 5 7 14 ];
    grad_Objective  = r.computeDoseObjectiveGradient(dos_);
    fun_Objective = r.computeDoseObjectiveFunction(dos_);

    
    isscalar(grad_ObjectiveGradient);
    %iscolum
    isscalar(fun_Objective);
    
    assertEqual(fun_Objective,zeros(length(dos_),length(dos_)))

    %Output Test if the input is a Column
    dos_ = [ 1 ; 3  ; 5 ; 7 ; 14 ];  

    fun = r.computeDoseObjectiveFunction(dos_);      
    grad = r.computeDoseObjectiveGradient(dos_);

    assertTrue(iscolumn(grad));
    assertTrue(isscalar (fun));

    assertEqual(length(grad),length(dos_));

    %Output Test if the input is a scalar
    dos_ = 14;
    fun1 = r.computeDoseObjectiveFunction(dos_);
    grad1 = r.computeDoseObjectiveGradient(dos_);

    assertTrue(iscolumn(grad1)); % asserttrue ,isscalar(fun)
    assertTrue(isscalar(fun1));

    assertEqual(length(grad1),length(dos_));

