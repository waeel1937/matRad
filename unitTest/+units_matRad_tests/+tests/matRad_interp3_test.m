classdef matRad_interp3_test  < matlab.unittest.TestCase
      
    methods (Test)

    %all and any 
        function testConstructor(testCase)
            matRad_cfg = MatRad_Config.instance();
            
           
            
%             testCase.verifyEqual(matRad_cfg.logLevel, 3); after set.log
%             have a new value 

            testCase.verifyEqual(matRad_cfg.keepLog, false);
            testCase.verifyEqual(matRad_cfg.writeLog, false);
        end
        
        function test_1(testCase)
            tic

            x = -1:1;
            y = -1:1;
            z = -1:1; 
            y = y + 2;
            f = @(x,y,z) x.^2 - y - z.^2;
            [xx, yy, zz] = meshgrid (x, y, z);
            v = f (xx,yy,zz);
            xi = -1:0.5:1;
            yi = -1:0.5:1;
            zi = -1:0.5:1;
            yi = yi + 2.1;
            [xxi, yyi, zzi] = meshgrid (xi, yi, zi);
            vi = matRad_interp3 (x, y, z, v, xxi, yyi, zzi);
            [xxi, yyi, zzi] = ndgrid (yi, xi, zi);
            vi2 = interpn (y, x, z, v, xxi, yyi, zzi);
            for i = 1: 2
            testCase.assertEqual  (vi(i,:), vi2(i,:));
            end 
            x =1:2;
            z = 1:2;
            y = 1:3;
            v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
            xi = .6:1.6;
            zi = .6:1.6;
            yi = 1;
            [xxi3, yyi3, zzi3] = meshgrid (xi, yi, zi);
            [xxi, yyi, zzi] = ndgrid (yi, xi, zi);
            vi = matRad_interp3 (x, y, z, v, xxi3, yyi3, zzi3, 'nearest');
            vi2 = interpn (y, x, z, v, xxi, yyi, zzi, 'nearest');

            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
            	assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end
            x = 1:2;
            z = 1:2;
            y = 1:3;
            v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
            xi = .6:1.6;
            zi = .6:1.6;
            yi = 1;
            % vi = matRad_interp3 (x, y, z, v, xi, yi, zi, 'nearest');
            % vi2 = interpn (y, x, z, v, yi, xi, zi, 'nearest');
            % testCase.assertEqual  (vi, vi2));
            x = 1:2;
            z = 1:2;
            y = 1:3;
            v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
            xi = .6:1.6;
            zi = .6:1.6;
            yi = 1;
            vi = matRad_interp3 (x, y, z, v, xi+1, yi, zi, 'nearest', 3);
            vi2 = interpn (y, x, z, v, yi, xi+1, zi, 'nearest', 3);
            testCase.assertEqual  (vi, vi2);
            x = 1:2;
            z = 1:2;
            y = 1:3;
            v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
            xi = .6:1.6;
            zi = .6:1.6;
            yi = 1;
            vi = matRad_interp3 (x,y,z,v, xi, yi, zi, 'nearest');
            vi2 = interpn (v, yi, xi, zi, 'nearest');
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end
            x = 1:2;
            z = 1:2;
            y = 1:3;
            v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
            xi = .6:1.6;
            zi = .6:1.6;
            yi = 1;
            vi = matRad_interp3 (x,y,z,v, xi, yi, zi, 'nearest', 3);
            vi2 = interpn (v, yi, xi, zi, 'nearest', 3);
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end
            X=[0,0.5,1]; 
            Y=X;
            Z=X;
            V = zeros (3,3,3);
            V(:,:,1) = [1 3 5; 3 5 7; 5 7 9];
            V(:,:,2) = V(:,:,1) + 2;
            V(:,:,3) = V(:,:,2) + 2;
            tol = 10 * eps;
            x = [-0.1,0,0.1];
            y = [-0.1,0,0.1]; 
            z = [-0.1,0,0.1];
            vi = matRad_interp3(X,Y,Z,V,x,y,z,'spline');
            vi2= [-0.2, 1.0, 2.2];
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end



            vi = matRad_interp3 (X,Y,Z,V,x,y,z,'linear');
            vi2=  [nan, 1.0000 , 2.2000];
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end



            vi = matRad_interp3 (X,Y,Z,V,x,y,z,'nearest');
            vi2=  [NaN 1 1];
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end




            vi = matRad_interp3(X,Y,Z,V,x,y,z,'spline',0);
            vi2= [0, 1.0, 2.2];
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end



            vi = matRad_interp3 (X,Y,Z,V,x,y,z,'linear',0);
            vi2=  [0, 1.0000 , 2.2000];
            expon = 1e+9;


            testCase.assertEqual(length(vi),length(vi2));
            for i = length(vi)
                assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
            end
            z = zeros (3, 3, 3);
            zout = zeros (5, 5, 5);
            z(:,:,1) = [1 3 5; 3 5 7; 5 7 9];
            z(:,:,2) = z(:,:,1) + 2;
            z(:,:,3) = z(:,:,2) + 2;
            for n = 1:5
            zout(:,:,n) = [1 2 3 4 5;
                     2 3 4 5 6;
                     3 4 5 6 7;
                     4 5 6 7 8;
                     5 6 7 8 9] + (n-1);
            end

            tol = 10 * eps;
            % testCase = matlab.unittest.TestCase.forInteractiveUse;

            testCase.assertError( @()  matRad_interp3 (z), 'MATLAB:minrhs');
            testCase.assertError( @()  matRad_interp3 (z, "linear"), 'MATLAB:minrhs');
            testCase.assertError( @()  matRad_interp3 (z, "spline"), 'MATLAB:minrhs');
            testCase.assertError( @()  matRad_interp3 (z, "pp"), 'MATLAB:minrhs');
            [x, y, z] = meshgrid (1:10);
            v = x;
            xi = linspace (1, 10, 20).';
            yi = linspace (1, 10, 20).';
            zi = linspace (1, 10, 20).';
            vi = matRad_interp3 (x, y, z, v, xi, yi, zi);
            testCase.assertEqual  (size (vi), [20, 1]);
            % 
            toc




            
        end
        

        

    end
   
end





















%_______________________________________________________MATLAB_______UniTEST
%% Test 1  # basic test



%% Test2  # meshgridded xi, yi, zi



%% Test3  # vector xi, yi, zi


%% Test4  # vector xi+1 with extrap value




%% Test5  # input value matrix--no x,y,z


%% Test6  # input value matrix--no x,y,z, with extrap value


%% Test7  # extrapolation



%% Test8  %shared z, zout, tol




%% Test9  <*57450>
%% Test10 input validation



% _______________________________________________________OCTAVE_______TEST

%!test  # basic test
%! x = y = z = -1:1;  y = y + 2;
%! f = @(x,y,z) x.^2 - y - z.^2;
%! [xx, yy, zz] = meshgrid (x, y, z);
%! v = f (xx,yy,zz);
%! xi = yi = zi = -1:0.5:1;  yi = yi + 2.1;
%! [xxi, yyi, zzi] = meshgrid (xi, yi, zi);
%! vi = interp3 (x, y, z, v, xxi, yyi, zzi);
%! [xxi, yyi, zzi] = ndgrid (yi, xi, zi);
%! vi2 = interpn (y, x, z, v, xxi, yyi, zzi);
%! testCase.assertEqual (vi, vi2, 10*eps);

%!test  # meshgridded xi, yi, zi
%! x = z = 1:2;  y = 1:3;
%! v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
%! xi = zi = .6:1.6;  yi = 1;
%! [xxi3, yyi3, zzi3] = meshgrid (xi, yi, zi);
%! [xxi, yyi, zzi] = ndgrid (yi, xi, zi);
%! vi = interp3 (x, y, z, v, xxi3, yyi3, zzi3, "nearest");
%! vi2 = interpn (y, x, z, v, xxi, yyi, zzi, "nearest");
%! testCase.assertEqual (vi, vi2);

%!test  # vector xi, yi, zi
%! x = z = 1:2;  y = 1:3;
%! v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
%! xi = zi = .6:1.6;  yi = 1;
%! vi = interp3 (x, y, z, v, xi, yi, zi, "nearest");
%! vi2 = interpn (y, x, z, v, yi, xi, zi, "nearest");
%! testCase.assertEqual (vi, vi2);

%!test  # vector xi+1 with extrap value
%! x = z = 1:2;  y = 1:3;
%! v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
%! xi = zi = .6:1.6;  yi = 1;
%! vi = interp3 (x, y, z, v, xi+1, yi, zi, "nearest", 3);
%! vi2 = interpn (y, x, z, v, yi, xi+1, zi, "nearest", 3);
%! testCase.assertEqual (vi, vi2);

%!test  # input value matrix--no x,y,z
%! x = z = 1:2;  y = 1:3;
%! v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
%! xi = zi = .6:1.6;  yi = 1;
%! vi = interp3 (v, xi, yi, zi, "nearest");
%! vi2 = interpn (v, yi, xi, zi, "nearest");
%! testCase.assertEqual (vi, vi2);

%!test  # input value matrix--no x,y,z, with extrap value
%! x = z = 1:2;  y = 1:3;
%! v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
%! xi = zi = .6:1.6;  yi = 1;
%! vi = interp3 (v, xi, yi, zi, "nearest", 3);
%! vi2 = interpn (v, yi, xi, zi, "nearest", 3);
%! testCase.assertEqual (vi, vi2);

%!test  # extrapolation
%! X=[0,0.5,1]; Y=X; Z=X;
%! V = zeros (3,3,3);
%! V(:,:,1) = [1 3 5; 3 5 7; 5 7 9];
%! V(:,:,2) = V(:,:,1) + 2;
%! V(:,:,3) = V(:,:,2) + 2;
%! tol = 10 * eps;
%! x = y = z = [-0.1,0,0.1];
%! testCase.assertEqual (interp3 (X,Y,Z,V,x,y,z,"spline"), [-0.2, 1.0, 2.2], tol);
%! testCase.assertEqual (interp3 (X,Y,Z,V,x,y,z,"linear"), [NA, 1.0, 2.2], tol);
%! testCase.assertEqual (interp3 (X,Y,Z,V,x,y,z,"spline", 0), [0, 1.0, 2.2], tol);
%! testCase.assertEqual (interp3 (X,Y,Z,V,x,y,z,"linear", 0), [0, 1.0, 2.2], tol);

%!shared z, zout, tol
%! z = zeros (3, 3, 3);
%! zout = zeros (5, 5, 5);
%! z(:,:,1) = [1 3 5; 3 5 7; 5 7 9];
%! z(:,:,2) = z(:,:,1) + 2;
%! z(:,:,3) = z(:,:,2) + 2;
%! for n = 1:5
%!   zout(:,:,n) = [1 2 3 4 5;
%!                  2 3 4 5 6;
%!                  3 4 5 6 7;
%!                  4 5 6 7 8;
%!                  5 6 7 8 9] + (n-1);
%! endfor
%! tol = 10 * eps;
%!
%!testCase.assertEqual (interp3 (z), zout, tol)
%!testCase.assertEqual (interp3 (z, "linear"), zout, tol)
%!testCase.assertEqual (interp3 (z, "spline"), zout, tol)

%!test <*57450>
%! [x, y, z] = meshgrid (1:10);
%! v = x;
%! xi = yi = zi = linspace (1, 10, 20).';
%! vi = interp3 (x, y, z, v, xi, yi, zi);
%! testCase.assertEqual (size (vi), [20, 1]);

% ## Test input validation
%!error <not enough input arguments> interp3 ()
%!error <Invalid call> interp3 ({1})
%!error <EXTRAPVAL must be a numeric scalar> interp3 (1,2,3,4,1,2,3,"linear", {1})
%!error <EXTRAPVAL must be a numeric scalar> interp3 (1,2,3,4,1,2,3,"linear", ones (2,2))
%!warning <ignoring unsupported '\*' flag> interp3 (rand (3,3,3), 1, "*linear");
%!error <V must be a 3-D array> interp3 (ones (2,2))
%!error <V must be a 3-D array> interp3 (ones (2,2), 1,1,1)
%!error <XI, YI, and ZI dimensions must be equal> interp3 (ones (2,2,2), 1,1, ones (2,2))
%!error <V must be a 3-D array> interp3 (1:2, 1:2, 1:2, ones (2,2), 1,1,1)
%!error <X, Y, Z, and V dimensions must be equal> interp3 (ones (1,2,2), ones (2,2,2), ones (2,2,2), ones (2,2,2), 1,1,1)
%!error <XI, YI, and ZI dimensions must be equal> interp3 (1:2, 1:2, 1:2, rand (2,2,2), 1,1, ones (2,2))
%!error <wrong number .* input arguments> interp3 (1:2, 1:2, 1:2)
 

