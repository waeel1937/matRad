



function testSuite = test_function_matRad_interp1_xunits
%testFunctionHandlesA Test file used by TestFunctionHandlesTest
%   Contains two passing tests.

%   Steven L. Eddins
%   Copyright 2008 The MathWorks, Inc.

localFunctionHandles = cellfun(@str2func, ...
  which('-subfun', mfilename('fullpath')), 'UniformOutput', false);
testSuite = buildFunctionHandleTestSuite(localFunctionHandles);

function s=randstr()
    s=char(20*rand(1,10)+65);



function test_function_matRad_interp1_scalar_Test1

    
    
    
   
    style = 'extrap';
    xp =   [ 2 3 ]  ;  %[ 3 6 ];
    yp =   [ 3 6 3 6; 3 6 3 6] ; 
    xi = [-1, 0, 2.2, 4, 6.6, 10, 11];
    testCase = matlab.unittest.TestCase.forInteractiveUse;
    
    vi = matRad_interp1 (xp,yp,xp,style);
    assertVectorsAlmostEqual(vi(1,:), yp(1,:));

    assert( isequal(matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style) ,yp) );
    assert (isequal (matRad_interp1 (xp,yp,xp,style), yp) );
    assert (isequal(matRad_interp1 (xp,yp,xp',style), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp,style), yp)) ;
    assert (isempty (matRad_interp1 (xp,yp,[],style)))  ;
    assert(matRad_interp1(1,1,1, style),1);
    assertError(testCase, @()  matRad_interp1 (xp',yp',xp',style), 'MATLAB:griddedInterpolant:CompVecValueMismatchErrId');
    assertError(testCase, @()  matRad_interp1 (xp',yp',[],style), 'MATLAB:griddedInterpolant:CompVecValueMismatchErrId');
    assertError(testCase, @()  [1 2]*[1 2 3], 'MATLAB:innerdim');
    
    
    
    
    
    
function test_function_matRad_interp1_scalar_Test2
    

    style = 'extrap';
    xp =   [ 2 3 ]  ; 
    yp =   [ 3 6 3 6; 3 6 3 6] ; 
    xi = [-1, 0, 2.2, 4, 6.6, 10, 11];
    style2 = 1;
    testCase = matlab.unittest.TestCase.forInteractiveUse;
    mat=[ style2 style2 style2 style2; style2 style2 style2 style2] ;
    
    vi  = matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style2);
    vi2 = mat;
    
    for i =  length(vi) 
        assertVectorsAlmostEqual(vi(:,i),vi2(:,i));
    end 
     
    vi  = matRad_interp1 (xp,yp,xp,style2);
    vi2 = yp;
    
    
    for i =  length(vi) 
        assertVectorsAlmostEqual(vi(:,i),vi2(:,i));
    end 
     
    
   
    assert (isequal(matRad_interp1 (xp,yp,xp',style2), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp,style2), yp)) ;

    assert( isequal(matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style2) ,mat ));
    assert (isequal (matRad_interp1 (xp,yp,xp,style2), yp) );
    assert (isequal(matRad_interp1 (xp,yp,xp',style2), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp,style2), yp)) ;
    testCase.assertError(@()assertEqual([1],'a'), 'assertEqual:classNotEqual');
    testCase.assertError( @() matRad_interp1 (xp',yp',xp',style), 'MATLAB:griddedInterpolant:CompVecValueMismatchErrId')
    assertError(testCase, @() matRad_interp1 (xp',yp',xp',style), 'MATLAB:griddedInterpolant:CompVecValueMismatchErrId');
    assert (isempty (matRad_interp1 (xp,yp,[],style2)))  ;
    assertError(testCase, @() matRad_interp1 (xp',yp',[],style2), 'MATLAB:griddedInterpolant:CompVecValueMismatchErrId');
    assertError(testCase, @()  assert (isequal(matRad_interp1 (xp,yp,xi,style2),matRad_interp1 (fliplr(xp),fliplr (yp),xi,style2))), 'MATLAB:griddedInterpolant:NonMonotonicCompVecsErrId');
    assert(matRad_interp1(1,1,1, style2),1);
    assert (isequal(matRad_interp1 (xp,[yp,yp],xi(:),style2),[matRad_interp1(xp,yp,xi(:),style2),matRad_interp1(xp,yp,xi(:),style2)]));
    assertError(testCase, @()  assert(matRad_interp1 (xp,yp,style2,"pp"),xi), 'MATLAB:assertion:LogicalScalar');
   
   
function test_function_matRad_interp1_scalar_Test3
     style = 'extrap';
    %  xp = [0:10] ;
    %  yp = sin (2*pi*xp/5) ;
    %  xi = [0:0.05:10];%[min(xp)-1, max(xp)+1])
    xp =   [ 2 3 ]  ;  %[ 3 6 ];
    yp =   [ 3 6 3 6; 3 6 3 6] ; 
    xi = [-1, 0, 2.2, 4, 6.6, 10, 11];
     style2 = 1;
     style1= 'extrap';

    mat1 = matRad_interp1 (xp,[yp,yp],xi,style);
    mat2 = matRad_interp1 (xp,[yp,yp],xi,style2);
    assert (isequal(mat1(3,:),mat2(3,:)));
    yp1 =[ 3 6 3 6; 3 6 3 6; 3 6 3 6; 3 6 3 6; 3 6 3 6];
    assert (isequal(matRad_interp1 ([1:5],yp1,[0:3],style),yp1(1:4,:)));
    assert (isequal(matRad_interp1 ([1:5],yp1,[0:3],style1),yp1(1:4,:)));
    vi = matRad_interp1 ([1:5],yp1,[0:3],style2);
    assert (isequal(vi(2:4,:),yp1(2:4,:)));
    






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


