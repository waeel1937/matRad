




addpath(genpath('C:\matRad\matRad\optimization'));

import DoseObjectives.matRad_MeanDose

%% Test 1: Quadratische Abweichung
dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};



r  =  matRad_MeanDose(dos);


assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0);
assertEqual(r.penalty,1);


%% Test 2: Quadratische Abweichung
dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};



r  =  matRad_MeanDose(dos);

% 
% SquaredDev = matRad_MeanDose.instance();

assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0);
assertEqual(r.penalty,1);





%% Test 3: Quadratische Abweichung
dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};


r  =  matRad_MeanDose(dos);


assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0);
assertEqual(r.penalty,1);


%% Test 4: Quadratische Abweichung
dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = 0 ; 

r  =  matRad_MeanDose(dos);



assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal);
assertEqual(r.penalty,1);





%% Test 5: Quadratische Abweichung


dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

r  =  matRad_MeanDose(dos);


assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0);
assertEqual(r.penalty,1);

%% Test 6 : Quadratische Abweichung & Dose Objective Function berechnen


dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};



r  =  matRad_MeanDose(dos);


assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, 0);
assertEqual(r.penalty,1);

sbioloadproject('AntibacterialPKPD')
em = export(m1);
doses = r.parameters{1};

r1  =  computeDoseObjectiveFunction(r,doses);

assertEqual(r1,0);

r2  = computeDoseObjectiveGradient(r,doses);

assertEqual(r2,0);

%% Test 7: Test the Gradient

dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

scal  = {0} ; 

r  =  matRad_MeanDose(dos);



assertEqual(r.name, 'Mean Dose');
assertEqual(r.parameterNames, dos.parameterNames);
assertEqual(r.parameters{1}, scal{1});
assertEqual(r.penalty,1);

dos.name = 'Mean Dose';
dos.parameterNames = {'d^{ref}'};
dos.parameterTypes = {'dose'};

r  =  matRad_MeanDose(dos);

dos_ = r.parameters{1} ;

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
