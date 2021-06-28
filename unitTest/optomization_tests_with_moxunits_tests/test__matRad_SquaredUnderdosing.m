


function test_suite=test__matRad_SquaredUnderdosing
% tests for MOxUnitFunctionHandleTestCase

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    
    
    

function test_1





addpath(genpath('C:\matRad\matRad\optimization'));

import DoseObjectives.matRad_SquaredUnderdosing 

%% Test 0: Quadratische Abweichung
dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min}'};
dos.parameterTypes = {'dose'};

scal  = 42 ; 

r  =  matRad_SquaredUnderdosing (dos,42);

% 
% SquaredDev = matRad_SquaredUnderdosing .instance();

assertEqual(r.name, 'Squared Underdosing');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);


%% Test 1: Quadratische Abweichung
dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min}'};
dos.parameterTypes = {'dose'};

scal  = 2 ; 

r  =  matRad_SquaredUnderdosing (dos,scal);

% 
% SquaredDev = matRad_SquaredUnderdosing .instance();

assertEqual(r.name, 'Squared Underdosing');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 2: Quadratische Abweichung


dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min}'};
dos.parameterTypes = {'dose'};

r  =  matRad_SquaredUnderdosing (dos);

% 
% SquaredDev = matRad_SquaredUnderdosing .instance();

assertEqual(r.name, 'Squared Underdosing');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 60);
assertEqual(r.penalty,1);

%% Test 3 : Quadratische Abweichung & Dose Objective Function berechnen


dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min}'};
dos.parameterTypes = {'dose'};



r  =  matRad_SquaredUnderdosing (dos);

% 
% SquaredDev = matRad_SquaredUnderdosing .instance();

assertEqual(r.name, 'Squared Underdosing');
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






%% Test 4: Test the Gradient


dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min}'};
dos.parameterTypes = {'dose'};

scal  = makedist('Normal') ; 

r  =  matRad_SquaredUnderdosing (dos,scal);

% 
% SquaredDev = matRad_SquaredUnderdosing .instance();

assertEqual(r.name, 'Squared Underdosing');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);

dos.name = 'Squared Underdosing';
dos.parameterNames = {'d^{min }'};
dos.parameterTypes = {'dose'};

r  =  matRad_SquaredUnderdosing (dos);

dos_ =  r.parameters{1} * 5;

grad_ObjectiveGradient  = r.computeDoseObjectiveGradient(dos_);

% test the gradient with gradient()
grad_gradient = gradient([r.parameters{1} dos_ ]) ;

resultat_of_grad1 =grad_gradient(1)* 2;

% test the gradient with gradient()
x = sym('x');
grad_jacobian = jacobian((dos_*x - r.parameters{1}*x)*2 , [x]) ;




assertEqual(resultat_of_grad1,double(grad_jacobian));
% assertEqual(grad_ObjectiveGradient,double(grad_jacobian));
% assertEqual(resultat_of_grad1,grad_ObjectiveGradient);

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
