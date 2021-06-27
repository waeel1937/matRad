





























































        
%        dos.name = array_name(k);
%        dos.parameterNames = para_names(k) ;
%        dos.parameterTypes = parameterTypes(k);








%        dos.name = array_name(k);
%        dos.parameterNames = para_names(k) ;
%        dos.parameterTypes = parameterTypes(k);
       
%        assertEqual(names , char(dos.name) );
% 
%        if names ~= "DoseObjectives.matRad_MaxDVH"
%            assertEqual(char(obj1.parameterNames(1)),char(para_names(k)) );
%        end
%        assertEqual(obj1.penalty,1);
%        assertEqual(obj1.parameterTypes(1),parameterTypes(k));





%dos =  { }
% scal  = 42 ; 
% mev = meta.package.fromName('DoseObjectives');
% for k=1:length(mev.Classes)-6
% 
%     r1 =  mev.Classes{k}.Name ;
%     if k > 1
%         r2 = mev.Classes{k+1}.PropertyList(2).DefaultValue(1);  
%         r3 = mev.Classes{k+1}.PropertyList(3).DefaultValue(1);
%         assertEqual(r2, para_names(k));
%         assertEqual(r3, parameterTypes(k));
% %         
%     end 
%     
%     assertEqual(r1 , char(array_name(k)));
%     %comp_fun %richtigen instanzenen erzeugt 
%     %abstract class test 
%         
% end

%-------------------------------------------------------------------------- 
% s = mev.Classes{1}.MethodList(1);
% s1 = mev.Classes{1};
% 
% dos.name = 'Squared Deviation';
% dos.parameterNames = {'d^{ref}'};
% dos.parameterTypes = {'dose'};
% 
% s = (dos);
% 
% 
% -------------------------------------------------------------------------

% mev = meta.package.fromName('DoseObjectives');

%        disp(MyClass.Name);
%         disp('abstract');
% 
%     %     r1 =  mev.Classes{k} ;
% %     dos.name  = array_name(k);
% %     dos.parameterNames = para_names(k);
% %     dos.parameterTypes = parameterTypes(k);
% 
%         %iscolum
%         disp(MyClass.Name);
%         disp('not abstract')
%         disp('Gradient output is a scalar   ? ');
%         disp(isscalar(grad));
%         disp('Function output is a scalar   ?  ');
%         disp(isscalar(fun));
%         disp('Function output is a Column   ?  ');
%         disp(iscolumn(fun));
%         disp('Gradient output is a Column   ?  ');
%         disp(iscolumn(grad));
%         
% %        assertEqual(isscalar(grad),isscalar(fun))
% 
%         %iscolum
%         disp(MyClass.Name);
%         disp('not abstract')
%         disp('Gradient output is a scalar   ? ');
%         disp(isscalar(grad));
%         disp('Function output is a scalar   ?  ');
%         disp(isscalar(fun));
%        assertEqual(isscalar(grad),isscalar(fun))