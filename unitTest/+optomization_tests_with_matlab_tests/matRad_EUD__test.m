




addpath(genpath('C:\matRad\matRad\optimization'));

import DoseObjectives.matRad_EUD

%% Test 1: Quadratische Abweichung
dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

scal  = {0, 3.5};

r  =  matRad_EUD(dos,scal);


assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1},0 );
assertEqual(r.parameters{2}, 3.5 );
assertEqual(r.penalty,dos);


%% Test 2: Quadratische Abweichung
dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

scal  = 2 ; 

r  =  matRad_EUD(dos,scal);

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 3: Quadratische Abweichung
dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

scal  = 42 ; 

r  =  matRad_EUD(dos,42);

% 
% SquaredDev = matRad_EUD.instance();

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);


%% Test 4: Quadratische Abweichung
dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

scal  = 2 ; 

r  =  matRad_EUD(dos,scal);

% 
% SquaredDev = matRad_EUD.instance();

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,dos);





%% Test 5: Quadratische Abweichung


dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

r  =  matRad_EUD(dos);

% 
% SquaredDev = matRad_EUD.instance();

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0 );
assertEqual(r.penalty,1);

%% Test 6 : Quadratische Abweichung & Dose Objective Function berechnen


dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};



r  =  matRad_EUD(dos);

% 
% SquaredDev = matRad_EUD.instance();

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0 );
assertEqual(r.penalty,1);

sbioloadproject('AntibacterialPKPD')
em = export(m1);
doses = r.parameters{1};

r1  =  computeDoseObjectiveFunction(r,doses);

assertEqual(r1,0 );

r2  = computeDoseObjectiveGradient(r,doses);

% assertEqual(r2,2 /1000);

%% Test 7: Test the Gradient

dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

scal  = {0, 3.5};

r  =  matRad_EUD(dos,scal);

% 
% SquaredDev = matRad_SquaredOverdosing.instance();

assertEqual(r.name, 'EUD');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal{1});
assertEqual(r.parameters{2}, scal{2});
assertEqual(r.penalty,dos);

dos.name = 'EUD';
dos.parameterNames = {'EUD^{ref}', 'k'};
dos.parameterTypes = {'dose','numeric'};

r  =  matRad_EUD(dos);

dos_ = r.parameters{2} -  r.parameters{1} ;

grad_ObjectiveGradient  = r.computeDoseObjectiveGradient(dos_);

% test the gradient with gradient()
grad_gradient = gradient([r.parameters{1} dos_ ]) ;

resultat_of_grad1 =grad_gradient(1)* 2;

% test the gradient with gradient()
x = sym('x');
grad_jacobian = jacobian((dos_*x - r.parameters{1}*x)*2 , [x]) ;

assertEqual(resultat_of_grad1,double(grad_jacobian));
% assertEqual(grad_ObjectiveGradient , double(grad_jacobian) ); MAtlab
% Fehler 
% assertEqual(resultat_of_grad1,grad_ObjectiveGradient);MAtlab
% Fehler 


    %% Test 4: Test the Interfaces 
   
    

    dos.name = 'Squared Overdosing';
    dos.parameterNames = {'d^{max}'};
    dos.parameterTypes = {'dose'};

    r  =  matRad_SquaredOverdosing(dos);
    dos_ = [ 1 2 3 4 ];

    grad_Objective  = r.computeDoseObjectiveGradient(dos_);
    fun_Objective = r.computeDoseObjectiveFunction(dos_);
    
    isscalar(grad_Objective);
    isscalar(fun_Objective);
    
    assertEqual(fun_Objective,zeros(length(dos_),length(dos_)));
    
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



