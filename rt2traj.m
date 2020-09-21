function trajf=rt2traj(data,tracks,minL)
if length(transpose(data{1}(1,:)))==2  %2D tracking
    traj = repmat(struct('x',[],'y',[],'u',[],'v',[],...		%Reconstruct the data matrix respect to the number of frames
    'ax',[],'ay',[],'t',[],'trajid',[]),length(tracks),1);
for i=1:length(tracks)
            temp=tracks{i};
    for j=1:length(temp)
        if isnan(temp(j))==0
        traj(i).x(j,1)=data{j}(temp(j),1);
        traj(i).y(j,1)=data{j}(temp(j),2);
        traj(i).t(j,1)=j;
        traj(i).trajid(j,1)=i;
        end
    end
end

for i=1:length(traj)
    traj(i).x(traj(i).t==0)=[];
    traj(i).y(traj(i).t==0)=[];
    traj(i).trajid(traj(i).t==0)=[];
    traj(i).t(traj(i).t==0)=[];
end

else

traj = repmat(struct('x',[],'y',[],'z',[],'u',[],'v',[],'w',[],...		%Reconstruct the data matrix respect to the number of frames
    'ax',[],'ay',[],'az',[],'t',[],'trajid',[]),length(tracks),1);
for i=1:length(tracks)
            temp=tracks{i};
    for j=1:length(temp)
        if isnan(temp(j))==0
        traj(i).x(j,1)=data{j}(temp(j),1);
        traj(i).y(j,1)=data{j}(temp(j),2);
        traj(i).z(j,1)=data{j}(temp(j),3);
        traj(i).t(j,1)=j;
        traj(i).trajid(j,1)=i;
        end
    end
end

for i=1:length(traj)
    traj(i).x(traj(i).t==0)=[];
    traj(i).y(traj(i).t==0)=[];
    traj(i).z(traj(i).t==0)=[];
    traj(i).trajid(traj(i).t==0)=[];
    traj(i).t(traj(i).t==0)=[];
end
end


j=0;
for i=1:length(traj)
    if length(traj(i).x)>minL
        j=j+1;
        trajf(j)=traj(i);
    end
end