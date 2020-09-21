clear all
Name = 'P3O190_1st';
Cali_Left = 60/760;
Cali_Right = 60/(1188-670);
LData = readtable(['Left_', Name, '.csv']);
RData = readtable(['Right_',Name, '.csv']);
L = min(length(LData.y), length(RData.y)); 
for i = 1:L
    LPoints{i} = [LData.x(i), LData.y(i)] * Cali_Left;
    RPoints{i} = [RData.x(i), RData.y(i)] * Cali_Right;
end
%%
tracksL=simpletracker(LPoints,'Debug',true,'MaxLinkingDistance',50,'MaxGapClosing',5);
trajL=rt2traj(LPoints,tracksL,5);
trajL=trajp2traj(trajL,1/200);
tracksR=simpletracker(RPoints,'Debug',true,'MaxLinkingDistance',50,'MaxGapClosing',5);
trajR=rt2traj(RPoints,tracksR,5);
trajR=trajp2traj(trajR,1/200);
%%

% x = trajL.x;
% y = trajL.y;
% figure(1)
% img = im2double(imread('P3O190\3rd\Left\Left0100.tif'));
% img = img/max(max(img));
% imshow(img);
% hold on;
% plot(x/Cali_Left,y/Cali_Left,'Color','r','LineWidth',2);
% hold off
% xL = (y - y(10));
% zL = x(1) - x;

%%
w = trajL.u;
u = trajL.v;
%%
% figure(3)
% scatter(x/Cali_Left,y/Cali_Left);
%%
% x = trajR.x;
% y = trajR.y;
% figure(2)
% img = im2double(imread('P3O190\3rd\Right\Right0130.tif'));
% img = img/max(max(img));
% imshow(img);
% hold on;
% plot(x/Cali_Right,y/Cali_Right,'Color','r','LineWidth',2);
% hold off;
% yR = (y(1) - y);
%%
v = trajR.v;
figure
uprime = sqrt(v.^2 + u.^2);
xplot = (0:(length(u)-1))*1/200*1000;
plot(xplot, uprime)
ylim([0,150]);
xlabel('t (ms)')
ylabel('mm/s')
saveas(gca,[Name,'Uprime.jpg'])
%%
asda
%%
% figure(4)
% scatter(x/Cali_Right,yR/Cali_Right)
%%
% traj3D = [xL,zL,yR];
%save([Name,'.mat'],'traj3D');
figure(5)
xplot = (0:(length(u)-1))*1/200 * 1000;
speed = sqrt(u.^2 + v.^2 + w.^2);
w = -w;
plot(xplot,u);
hold on;
plot(xplot,v);
hold on;
plot(xplot,w);
hold on;
plot(xplot,speed);
hold off;
legend('u','v','w','speed', 'Location', 'eastoutside');
xlabel('t (ms)');
ylabel('mm/s');
saveas(gca,[Name,'.jpg']);
%%
V = zeros(10000,1);
V(1:L) = u
sp = fft(V);
L = length(V);
P2 = abs(sp/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = 200*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%% 
% Plot the top view of trajectory
%%
clear all;
Name = 'P3O190_3rd';
load([Name,'.mat']);
figure(1)
plot(traj3D(:,1),traj3D(:,3));
xlabel('X');
ylabel('Y');
axis equal
xlim([-15, 15])
ylim([-15, 15])
saveas(gca,[Name,'TopView.jpg']);