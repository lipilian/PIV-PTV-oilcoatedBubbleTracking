clear all
Uall=[];
Vall=[];
Bad=[];

%% use importdata to read file
name1 = 'Analysis/9';
title1 = 'HZ_exp_up_crop00000';
title2 = 'HZ_exp_up_crop0000';
title3 = 'HZ_exp_up_crop000';
title4 = 'HZ_exp_up_crop00';
n = 1899;
for i= 1: n
    if i<10
        temp=importdata([name1 title1 num2str(i) '.T000.D000.P000.H000.L.vec']);
    end
    if i>=10&&i<100
        temp=importdata([name1 title2 num2str(i) '.T000.D000.P000.H000.L.vec']);
    end
    if i>=100&&i<1000
        temp=importdata([name1 title3 num2str(i) '.T000.D000.P000.H000.L.vec']);
    end
    if i>=1000&&i<10000
        temp=importdata([name1 title4 num2str(i) '.T000.D000.P000.H000.L.vec']);
    end
    inst=temp.data;
   
    Uall=[Uall inst(:,3)];
    Vall=[Vall inst(:,4)];  
    i
end
   

X=inst(:,1);
Y=inst(:,2);
% UM=mean(Uall');
% VM=mean(Vall');
% UM=UM';
% VM=VM';

% [ud,ix,iy] = unique(Y);
% UM = [accumarray(iy,UM,[],@mean)];
% ud = ud - min(ud);
% figure(1)
% plot(UM/max(UM),ud,'*')
save('9HZ_high_up_crop.mat','Uall','Vall','X','Y');




%% storing point values in another format
% K = [X Y Uall Vall];
% 
% save 45hz_08hz_U.txt K -ascii 
%save 45hz_Preliminary.txt Vall -ascii
%save 45hz_08hz_V.txt Vall -ascii