function [traj,trajLen] = trajp2traj_nopositionfilter(trajt,dt)
if isfield(trajt,'z')==0  %2D tracking
traj = repmat(struct('x',[],'y',[],'u',[],'v',[],...
    'ax',[],'ay',[],'t',[],'trajid',[]),length(trajt),1);

for k = 1:length(trajt)   
    [traj(k).x,traj(k).u,traj(k).ax] = smoothspline(trajt(k).t*dt,trajt(k).x);
    [traj(k).y,traj(k).v,traj(k).ay] = smoothspline(trajt(k).t*dt,trajt(k).y);
    traj(k).t=trajt(k).t;
    traj(k).trajid=trajt(k).trajid;
    traj(k).x=trajt(k).x;
    traj(k).y=trajt(k).y;
end
else

traj = repmat(struct('x',[],'y',[],'z',[],'u',[],'v',[],'w',[],...
    'ax',[],'ay',[],'az',[],'t',[],'trajid',[]),length(trajt),1);

for k = 1:length(trajt)   
    [traj(k).x,traj(k).u,traj(k).ax] = smoothspline(trajt(k).t*dt,trajt(k).x);
    [traj(k).y,traj(k).v,traj(k).ay] = smoothspline(trajt(k).t*dt,trajt(k).y);
    [traj(k).z,traj(k).w,traj(k).az] = smoothspline(trajt(k).t*dt,trajt(k).z);
    traj(k).t=trajt(k).t;
    traj(k).trajid=trajt(k).trajid;
    traj(k).x=trajt(k).x;
    traj(k).y=trajt(k).y;
    traj(k).z=trajt(k).z;
end
end







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
