function [ys,df,ddf] = smoothspline(x,y)
% w = ones(size(x)); w([1 end]) = 1.e-5;
% [sp,ys] = spaps(x,y, 1.e-2, w, 3);
% ys = smooth1q(y,'dct');
% [sp,ys] = spaps(x,y,1);
% h = x(2) - x(1);
% p = 1/(1 + h^3/6);
% [sp] = csaps(x,y,p);
% sp = csape(x,y,'variational');

l = min(21,floor(length(x)/5));
sp = spap2(l,4,x,y);
ys = fnval(sp,x);
df = fnval(fnder(sp),x);
ddf = fnval(fnder(sp,2),x);