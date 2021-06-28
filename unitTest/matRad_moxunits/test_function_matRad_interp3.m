
function test_suite=test_function_matRad_interp3
% tests for MOxUnitFunctionHandleTestCase

    tic
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
   
    initTestSuite;
    toc

function s=randstr()
    s=char(20*rand(1,10)+65);
% 
function test_function_matRad_interp3_scalar_Test1
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
        assert (isequal(vi(i,:), vi2(i,:)));
    end   

function test_function_matRad_interp3_scalar_Test3
    
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


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end
function test_function_matRad_interp3_scalar_Test4
   
    
    x = 1:2;
    z = 1:2;
    y = 1:3;
    v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
    xi = .6:1.6;
    zi = .6:1.6;
    yi = 1;

    vi = matRad_interp3 (x, y, z, v, xi, yi, zi, 'nearest');
    vi2 = interpn (y, x, z, v, yi, xi, zi, 'nearest');

    vi(isnan(vi(:,1)),:) = [0];
    vi2(isnan(vi2(:,1)),:) = [0];

    assert (isequal(vi, vi2));
    
    
    
    
function test_function_matRad_interp3_scalar_Test5
    x = 1:2;
    z = 1:2;
    y = 1:3;
    v = ones ([3,2,2]);  v(:,2,1) = [7;5;4];  v(:,1,2) = [2;3;5];
    xi = .6:1.6;
    zi = .6:1.6;
    yi = 1;
    vi = matRad_interp3 (x, y, z, v, xi+1, yi, zi, 'nearest', 3);
    vi2 = interpn (y, x, z, v, yi, xi+1, zi, 'nearest', 3);
    assert (isequal(vi, vi2));

function test_function_matRad_interp3_scalar_Test6
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


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end


function test_function_matRad_interp3_scalar_Test7
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


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end

function test_function_matRad_interp3_scalar_Test8

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


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end

    %% Test7  # extrapolation
    X=[0,0.5,1]; 
    Y=X;
    Z=X;
    V = zeros (3,3,3);
    V(:,:,1) = [1 3 5; 3 5 7; 5 7 9];
    V(:,:,2) = V(:,:,1) + 2;
    V(:,:,3) = V(:,:,2) + 2;
    % tol = 10 * eps;
    x = [-0.1,0,0.1];
    y = [-0.1,0,0.1]; 
    z = [-0.1,0,0.1];
    vi = matRad_interp3(X,Y,Z,V,x,y,z,'spline');
    vi2= [-0.2, 1.0, 2.2];
    expon = 1e+9;


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end



    vi = matRad_interp3 (X,Y,Z,V,x,y,z,'linear');
    vi2=  [nan, 1.0000 , 2.2000];
    expon = 1e+9;


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end



    vi = matRad_interp3 (X,Y,Z,V,x,y,z,'nearest');
    vi2=  [NaN 1 1];
    expon = 1e+9;


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end




    vi = matRad_interp3(X,Y,Z,V,x,y,z,'spline',0);
    vi2= [0, 1.0, 2.2];
    expon = 1e+9;


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end



    vi = matRad_interp3 (X,Y,Z,V,x,y,z,'linear',0);
    vi2=  [0, 1.0000 , 2.2000];
    expon = 1e+9;


    assert(length(vi),length(vi2));
    for i = length(vi)
    assert (uint32(vi(i)*expon) == uint32(vi2(i)*expon));
    end

    
function test_function_matRad_interp3_scalar_Test9
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

    assertError( @()  matRad_interp3 (z), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (z, "linear"), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (z, "spline"), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (z, "pp"), 'MATLAB:minrhs');





    %% Test9  <*57450>
    [x, y, z] = meshgrid (1:10);
    v = x;
    xi = linspace (1, 10, 20).';
    yi = linspace (1, 10, 20).';
    zi = linspace (1, 10, 20).';
    vi = matRad_interp3 (x, y, z, v, xi, yi, zi);
    assert (isequal(size (vi), [20, 1]));
    % 
    %% Test10 input validation


    assertError( @()  matRad_interp3 (), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (1), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (1,2,3,4,1,2,3,"linear", ones (2,2)), 'MATLAB:interp3:InvalidExtrapval');
    assertError( @()  matRad_interp3 (1,2,3,4,1,2,3,"linear", {1}), 'MATLAB:interp3:InvalidExtrapval');




    assertError( @()  matRad_interp3 (rand (3,3,3), 1, "*linear"), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (ones (2,2), 'MATLAB:minrhs'));
    assertError( @()  matRad_interp3  (ones (2,2), 1,1,1), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (ones (2,2,2), 1,1, ones (2,2)), 'MATLAB:minrhs');
    assertError( @()  matRad_interp3 (1:2, 1:2, 1:2, ones (2,2), 1,1,1),...
        'MATLAB:griddedInterpolant:NumCoordsGridNdimsMismatchErrId');
    assertError( @()  matRad_interp3 (ones (1,2,2), ones (2,2,2), ones (2,2,2), ones (2,2,2), 1,1,1), 'MATLAB:griddedInterpolant:BadGridErrId');
    assertError( @()  matRad_interp3 (1:2, 1:2, 1:2, rand (2,2,2), 1,1, ones (2,2)), 'MATLAB:griddedInterpolant:InputMixSizeErrId');
    assertError( @()  matRad_interp3 (1:2, 1:2, 1:2), 'MATLAB:minrhs');

    
    
    
    
function test_function_handle_test_case_reset_warning()
    if moxunit_util_platform_is_octave()
        reason=['resetting the warning state seems not to work ' ...
                '(TODO: file a bug report?)'];
        moxunit_throw_test_skipped_exception(reason);
        return;
    end

    s=warning('query');
    state_resetter=onCleanup(@()warning(s));

    % generate unique id
    id=sprintf('%s:%s:%s',randstr(),randstr(),randstr());

    assertEqual(get_warning_state(id),[])

    name=randstr();
    location=randstr();
    func=@()warning('off',id);
    f=MOxUnitFunctionHandleTestCase(name, location, func);
    rep=MOxUnitTestReport(0,1);
    run(f,rep);

    assertEqual(get_warning_state(id),[])

function s=get_warning_state(id)
% return empty array if warning state not present, or 'on' or 'off'
    w=warning('query');
    idx=find(strcmp(id,{w.identifier}))';

    if isempty(idx)
        s=[];
        return;
    end

    assert(numel(idx)==1);
    s=w(idx).state;


function disable_warning(id)
    warning('off',id);

function do_nothing()

    % do nothing
   


