
%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
%-----------------*****   MATLAB  with UniTEST *****---------------------------
%------------------------------------------------------------------------------
tic


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



%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
%-----------------*****   OCTAVE  with UniTEST *****---------------------------
%------------------------------------------------------------------------------

%!demo
%! clf;
%! xf = 0:0.05:10;  yf = sin (2*pi*xf/5);
%! xp = 0:10;       yp = sin (2*pi*xp/5);
%! lin = matRad_interp1 (xp,yp,xf, 'linear');
%! spl = matRad_interp1 (xp,yp,xf, 'spline');
%! pch = matRad_interp1 (xp,yp,xf, 'pchip');
%! near= matRad_interp1 (xp,yp,xf, 'nearest');
%! plot (xf,yf,'r',xf,near,'g',xf,lin,'b',xf,pch,'c',xf,spl,'m',xp,yp,'r*');
%! legend ('original', 'nearest', 'linear', 'pchip', 'spline');
%! title ('Interpolation of continuous function sin (x) w/various methods');
%! %--------------------------------------------------------
%! % confirm that interpolated function matches the original

%!demo
%! clf;
%! xf = 0:0.05:10;  yf = sin (2*pi*xf/5);
%! xp = 0:10;       yp = sin (2*pi*xp/5);
%! lin = matRad_interp1 (xp,yp,xf, '*linear');
%! spl = matRad_interp1 (xp,yp,xf, '*spline');
%! pch = matRad_interp1 (xp,yp,xf, '*pchip');
%! near= matRad_interp1 (xp,yp,xf, '*nearest');
%! plot (xf,yf,'r',xf,near,'g',xf,lin,'b',xf,pch,'c',xf,spl,'m',xp,yp,'r*');
%! legend ('*original', '*nearest', '*linear', '*pchip', '*spline');
%! title ('Interpolation of continuous function sin (x) w/various *methods');
%! %--------------------------------------------------------
%! % confirm that interpolated function matches the original

%!demo
%! clf;
%! fstep = @(x) x > 1;
%! xf = 0:0.05:2;  yf = fstep (xf);
%! xp = linspace (0,2,10);  yp = fstep (xp);
%! pch = matRad_interp1 (xp,yp,xf, 'extrap');
%! spl = matRad_interp1 (xp,yp,xf, 'extrap');
%! plot (xf,yf,'r',xf,pch,'b',xf,spl,'m',xp,yp,'r*');
%! title ({'Interpolation of step function with discontinuity at x==1', ...
%!         'Note: "pchip" is shape-preserving, "spline" (continuous 1st, 2nd derivatives) is not'});
%! legend ('original', 'pchip', 'spline');

%!demo
%! clf;
%! t = 0 : 0.3 : pi; dt = t(2)-t(1);
%! n = length (t); k = 100; dti = dt*n/k;
%! ti = t(1) + [0 : k-1]*dti;
%! y = sin (4*t + 0.3) .* cos (3*t - 0.1);
%! ddys = diff (diff (matRad_interp1 (t,y,ti, 'spline'))./dti)./dti;
%! ddyp = diff (diff (matRad_interp1 (t,y,ti, 'pchip')) ./dti)./dti;
%! ddyc = diff (diff (matRad_interp1 (t,y,ti, 'cubic')) ./dti)./dti;
%! plot (ti(2:end-1),ddys,'b*', ti(2:end-1),ddyp,'c^', ti(2:end-1),ddyc,'g+');
%! title ({'Second derivative of interpolated "sin (4*t + 0.3) .* cos (3*t - 0.1)"', ...
%!         'Note: "spline" has continuous 2nd derivative, others do not'});
%! legend ('spline', 'pchip', 'cubic');

%!demo
%! clf;
%! xf = 0:0.05:10;                yf = sin (2*pi*xf/5) - (xf >= 5);
%! xp = [0:.5:4.5,4.99,5:.5:10];  yp = sin (2*pi*xp/5) - (xp >= 5);
%! lin = matRad_interp1 (xp,yp,xf, 'linear');
%! near= matRad_interp1 (xp,yp,xf, 'nearest');
%! plot (xf,yf,'r', xf,near,'g', xf,lin,'b', xp,yp,'r*');
%! legend ('original', 'nearest', 'linear');
%! %--------------------------------------------------------
%! % confirm that interpolated function matches the original

%!demo
%! clf;
%! x = 0:0.5:3;
%! x1 = [3 2 2 1];
%! x2 = [1 2 2 3];
%! y1 = [1 1 0 0];
%! y2 = [0 0 1 1];
%! h = plot (x, matRad_interp1 (x1, y1, x), 'b', x1, y1, 'sb');
%! hold on
%! g = plot (x, matRad_interp1 (x2, y2, x), 'r', x2, y2, '*r');
%! axis ([0.5 3.5 -0.5 1.5]);
%! legend ([h(1), g(1)], {'left-continuous', 'right-continuous'}, ...
%!         'location', 'northwest')
%! legend boxoff
%! %--------------------------------------------------------
%! % red curve is left-continuous and blue is right-continuous at x = 2




%!shared xp, yp, xi, style
%! xp = 0:2:10;
%! yp = sin (2*pi*xp/5);
%! xi = [-1, 0, 2.2, 4, 6.6, 10, 11];

% 
% %!test style = "nearest";
% ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
% ## ENDBLOCK
% 
% %!test style = "previous";
% ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
% ## This test is expected to fail, so commented out.
% ## "previous" and "next" options are not symmetric w.r.t to flipping xp,yp
% #%!assert (matRad_interp1 (xp,yp,xi,style),...
% #%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
% #%!assert (matRad_interp1 (xp,yp,xi,style),...
% #%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
% %!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
% ## ENDBLOCK
% 
% %!test style = "next";
% ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
% #%!assert (matRad_interp1 (xp,yp,xi,style),...
% #%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
% %!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
% #%!assert (matRad_interp1 (xp,yp,xi,style),...
% #%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
% % ## ENDBLOCK
% % 
% % %!test style = "linear";
% % ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ['*',style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!assert (matRad_interp1 ([1 2 2 3], [1 2 3 4], 2), 3)
%!assert (matRad_interp1 ([3 2 2 1], [4 3 2 1], 2), 2)
%!error matRad_interp1 (1,1,1, style)
% % ## ENDBLOCK
% % 
% % %!test style = "cubic";
% % ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),100*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),100*eps)
%!error matRad_interp1 (1,1,1, style)
% % ## ENDBLOCK
% % 
% % %!test style = "pchip";
% % ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
% % ## ENDBLOCK
% % 
% % %!test style = "spline";
% % ## BLOCK
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
%!assert (matRad_interp1 (xp,[yp',yp'],xi,style),
%!        matRad_interp1 (xp,[yp',yp'],xi,["*",style]),100*eps)
%!test style = ["*",style];
%!assert (matRad_interp1 (xp, yp, [min(xp)-1, max(xp)+1],style), [NA, NA])
%!assert (matRad_interp1 (xp,yp,xp,style), yp, 100*eps)
%!assert (matRad_interp1 (xp,yp,xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp',style), yp', 100*eps)
%!assert (matRad_interp1 (xp',yp',xp,style), yp, 100*eps)
%!assert (isempty (matRad_interp1 (xp',yp',[],style)))
%!assert (isempty (matRad_interp1 (xp,yp,[],style)))
%!assert (matRad_interp1 (xp,[yp',yp'],xi(:),style),...
%!        [matRad_interp1(xp,yp,xi(:),style),matRad_interp1(xp,yp,xi(:),style)])
%!assert (matRad_interp1 (xp,yp,xi,style),...
%!        matRad_interp1 (fliplr (xp),fliplr (yp),xi,style),100*eps)
%!assert (ppval (matRad_interp1 (xp,yp,style,"pp"),xi),
%!        matRad_interp1 (xp,yp,xi,style,"extrap"),10*eps)
%!error matRad_interp1 (1,1,1, style)
% % ## ENDBLOCK
% % ## ENDBLOCKTEST
% % % % 
% % ## test extrapolation
%!assert (matRad_interp1 ([1:5],[3:2:11],[0,6],"linear","extrap"), [1, 13], eps)
%!assert (matRad_interp1 ([1:5],[3:2:11],[0,6],"nearest","extrap"), [3, 11], eps)
%!assert (matRad_interp1 ([1:5],[3:2:11],[0,6],"previous","extrap"), [3, 11], eps)
%!assert (matRad_interp1 ([1:5],[3:2:11],[0,6],"next","extrap"), [3, 11], eps)
%!assert (matRad_interp1 (xp, yp, [-1, max(xp)+1],"linear",5), [5, 5])
%!assert (matRad_interp1 ([0,1],[1,0],[0.1,0.9;0.2,1.1]), [0.9 0.1; 0.8 NA], eps)
%!assert (matRad_interp1 ([0,1],[1,0],[0.1,0.9;0.2,1]), [0.9 0.1; 0.8 0], eps)

% % ## Basic sanity checks
%!assert (matRad_interp1 (1:2,1:2,1.4,"nearest"), 1)
%!assert (matRad_interp1 (1:2,1:2,1.6,"previous"), 1)
%!assert (matRad_interp1 (1:2,1:2,1.4,"next"), 2)
%!assert (matRad_interp1 (1:2,1:2,1.4,"linear"), 1.4)
%!assert (matRad_interp1 (1:4,1:4,1.4,"cubic"), 1.4)
%!assert (matRad_interp1 (1:2,1:2,1.1,"spline"), 1.1)
%!assert (matRad_interp1 (1:3,1:3,1.4,"spline"), 1.4)

%!assert (matRad_interp1 (1:2:4,1:2:4,1.4,"*nearest"), 1)
%!assert (matRad_interp1 (1:2:4,1:2:4,2.2,"*previous"), 1)
%!assert (matRad_interp1 (1:2:4,1:2:4,1.4,"*next"), 3)
%!assert (matRad_interp1 (1:2:4,1:2:4,[0,1,1.4,3,4],"*linear"), [NA,1,1.4,3,NA])
%!assert (matRad_interp1 (1:2:8,1:2:8,1.4,"*cubic"), 1.4)
%!assert (matRad_interp1 (1:2,1:2,1.3, "*spline"), 1.3)
%!assert (matRad_interp1 (1:2:6,1:2:6,1.4,"*spline"), 1.4)

%!assert (matRad_interp1 ([3,2,1],[3,2,2],2.5), 2.5)

%!assert (matRad_interp1 ([4,4,3,2,0],[0,1,4,2,1],[1.5,4,4.5], "linear"), [1.75,1,NA])
%!assert (matRad_interp1 (0:4, 2.5), 1.5)

% % ## Left and Right discontinuities
%!assert (matRad_interp1 ([1,2,2,3,4],[0,1,4,2,1],[-1,1.5,2,2.5,3.5], "linear", "extrap", "right"), [-2,0.5,4,3,1.5])
%!assert (matRad_interp1 ([1,2,2,3,4],[0,1,4,2,1],[-1,1.5,2,2.5,3.5], "linear", "extrap", "left"), [-2,0.5,1,3,1.5])

% % ## Test input validation
%!error matRad_interp1 ()
%!error matRad_interp1 (1,2,3,4,5,6,7)
%!error <minimum of 2 points required> matRad_interp1 (1,1,1, "linear")
%!error <minimum of 2 points required> matRad_interp1 (1,1,1, "*nearest")
%!error <minimum of 2 points required> matRad_interp1 (1,1,1, "*linear")
%!error <minimum of 2 points required> matRad_interp1 (1,1,1, "previous")
%!error <minimum of 2 points required> matRad_interp1 (1,1,1, "*previous")
%!warning <multiple discontinuities> matRad_interp1 ([1 1 1 2], [1 2 3 4], 1);
%!error <discontinuities not supported> matRad_interp1 ([1 1],[1 2],1, "next")
%!error <discontinuities not supported> matRad_interp1 ([1 1],[1 2],1, "pchip")
%!error <discontinuities not supported> matRad_interp1 ([1 1],[1 2],1, "cubic")
%!error <discontinuities not supported> matRad_interp1 ([1 1],[1 2],1, "spline")
%!error <invalid METHOD 'invalid'> matRad_interp1 (1:2,1:2,1, "invalid")




toc


