



function test_suite=test_function_matRad_interp1
% tests for MOxUnitFunctionHandleTestCase
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; earlya Matlab versions can use initTestSuite fine
    end
    initTestSuite;

function s=randstr()
    s=char(20*rand(1,10)+65);

function test_function_matRad_interp1_scalar_Test1

    
    
    style = 'extrap';
    %  xp = [0:10] ;
    %  yp = sin (2*pi*xp/5) ;
    %  xi = [0:0.05:10];%[min(xp)-1, max(xp)+1])
    xp =   [ 2 3 ]  ;  %[ 3 6 ];
    yp =   [ 3 6 3 6; 3 6 3 6] ; 
    xi = [-1, 0, 2.2, 4, 6.6, 10, 11];
    %all and any 
    %% Test 1: style ==  extrap

    assert( isequal(matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style) ,yp) );
    assert (isequal (matRad_interp1 (xp,yp,xp,style), yp) );
    assert (isequal(matRad_interp1 (xp,yp,xp',style), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp,style), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp',style), yp)) ;
    assert (isempty (matRad_interp1 (xp,yp,[],style)))  ;
    assert (isempty (matRad_interp1 (xp',yp,[],style)))  ;
    assert (isequal(matRad_interp1 (xp,fliplr(yp),xi,style),matRad_interp1 (fliplr(xp'),fliplr (yp),xi,style))); % Failed 
    assert(matRad_interp1(1,1,1, style),1);
    %assert(isequal(matRad_interp1(xp,yp,xi,'pp'), 'Invalid extrapolation argument!'));%True if the Error Massage from typ String 

    %% Test 2: style ==  scalar
    style2 = 1;
    mat=[ style2 style2 style2 style2; style2 style2 style2 style2] ; 
    assert( isequal(matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style2) ,mat ));
    assert (isequal (matRad_interp1 (xp,yp,xp,style2), yp) );
    assert (isequal(matRad_interp1 (xp,yp,xp',style2), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp,style2), yp)) ;
    assert (isequal(matRad_interp1 (xp',yp,xp',style2), yp)) ;
    assert (isempty (matRad_interp1 (xp,yp,[],style2)))  ;
    assert (isempty (matRad_interp1 (xp',yp,[],style2)))  ;
    assert (isequal(matRad_interp1 (xp,yp,xi,style2),fliplr(matRad_interp1 (xp,fliplr (yp),xi,style2)))); % Failed matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps);
    assert(matRad_interp1(1,1,1, style2),1);

    assert (isequal(matRad_interp1 (xp,[yp,yp],xi(:),style2),[matRad_interp1(xp,yp,xi(:),style2),matRad_interp1(xp,yp,xi(:),style2)]));
    assertEqual(matRad_interp1 (xp,yp,style2,"pp"),"pp");

    %% Test 3:  style2 and style1
    style2 = 1;
    style1= 'extrap';

    mat1 = matRad_interp1 (xp,[yp,yp],xi,style);
    mat2 = matRad_interp1 (xp,[yp,yp],xi,style2);
    assert (isequal(mat1(3,:),mat2(3,:)));
    yp1 =[ 3 6 3 6; 3 6 3 6; 3 6 3 6; 3 6 3 6; 3 6 3 6];
    assert (isequal(matRad_interp1 ([1:5],yp1,[0:3],style),yp1(1:4,:)));

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


