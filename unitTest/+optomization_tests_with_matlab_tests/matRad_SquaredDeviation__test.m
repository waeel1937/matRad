




addpath(genpath('C:\matRad\matRad\optimization'));

import DoseObjectives.matRad_SquaredDeviation

%% Test 1: Quadratische Abweichung
dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = 42 ; 

r  =  matRad_SquaredDeviation(dos,42);


assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);


%% Test 2: Quadratische Abweichung
dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = 2 ; 

r  =  matRad_SquaredDeviation(dos,scal);

% 
% SquaredDev = matRad_SquaredDeviation.instance();

assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 3: Quadratische Abweichung
dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = 42 ; 

r  =  matRad_SquaredDeviation(dos,42);


assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);


%% Test 4: Quadratische Abweichung
dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = 2 ; 

r  =  matRad_SquaredDeviation(dos,scal);


assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 5: Quadratische Abweichung


dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

r  =  matRad_SquaredDeviation(dos);


assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 60);
assertEqual(r.penalty,1);

%% Test 6 : Quadratische Abweichung & Dose Objective Function berechnen


dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};



r  =  matRad_SquaredDeviation(dos);


assertEqual(r.name, 'Squared Deviation');
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

dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = makedist('Normal') ; 

r  =  matRad_SquaredDeviation(dos,scal);



assertEqual(r.name, 'Squared Deviation');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);

dos.name = 'Squared Deviation';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

r  =  matRad_SquaredDeviation(dos);

dos_ =  r.parameters{1} * 5;

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

    
    
    