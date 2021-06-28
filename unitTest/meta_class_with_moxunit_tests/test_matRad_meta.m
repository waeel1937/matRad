






function test_suite=test_matRad_meta
% tests for MOxUnitFunctionHandleTestCase

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    
    
    

function test_The_Optomization_Classes



addpath(genpath('C:\matRad\matRad\optimization'));

array_name = { 'DoseObjectives.matRad_SquaredDeviation','DoseObjectives.matRad_SquaredUnderdosing','DoseObjectives.matRad_EUD', 'DoseObjectives.matRad_MaxDVH','DoseObjectives.matRad_MeanDose',  'DoseObjectives.matRad_MinDVH' ,...
'DoseObjectives.matRad_SquaredDeviation','DoseObjectives.matRad_SquaredOverdosing','DoseObjectives.matRad_SquaredUnderdosing'} ; %x
para_names =  { 'EUD^{ref}','d^{min}', 'EUD^{ref}', {'EUD^{ref}'} ,'d^{ref}','d','d^{ref}','d^{max}','d^{min}' } ;
parameterTypes = {'dose' ,'dose' ,'dose','dose' ,'dose','dose' ,'dose','dose' ,'dose','dose' ,'dose'} ;

mev = meta.package.fromName('DoseObjectives');
for k=1:8%length(mev.Classes)

    mev = meta.package.fromName('DoseObjectives');
    MyClass = mev.Classes{k};

    if ~MyClass.Abstract

       % not an abstract class
       obj1 =  eval(MyClass.Name) ;
       names = MyClass.Name ; 
       % Name Test

       assertEqual(names ,char(array_name(k)));

       %Output Test if the input is a Column
       dos_ = [ 1 ; 3  ; 5 ; 7 ; 14 ];  

       fun = obj1.computeDoseObjectiveFunction(dos_);      
       grad = obj1.computeDoseObjectiveGradient(dos_);

       assertTrue(iscolumn(grad));
       assertTrue(isscalar (fun));

       assertEqual(length(grad),length(dos_));

       %Output Test if the input is a scalar
       dos_ = 14;
       fun1 = obj1.computeDoseObjectiveFunction(dos_);
       grad1 = obj1.computeDoseObjectiveGradient(dos_);

       assertTrue(iscolumn(grad1)); % asserttrue ,isscalar(fun)
       assertTrue(isscalar(fun1));

       assertEqual(length(grad1),length(dos_));

       if names ~= "DoseObjectives.matRad_MaxDVH"
           assertEqual(char(obj1.parameterNames(1)),char(para_names(k)) );
       end
       assertEqual(obj1.penalty,1);
       assertEqual(obj1.parameterTypes(1),parameterTypes(k));

    else 



    end
end


 