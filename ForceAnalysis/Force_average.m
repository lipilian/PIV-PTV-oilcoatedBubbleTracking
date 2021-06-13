clear all;

Cases = readtable('info.csv');

density_w = 998;
density_10 = 930;
density_100 = 960;
density_air = 1.225;
dt = 1/200;

info = readtable('experiment_infoMatLab.csv');

trajInfoPath = 'C:\Users\liuhong2\Box\BubbleRising\PaperGraph\SideViewTime';


file = dir('*.xlsx');
filenames = extractfield(file,'name');
fo10 = info.x10fo(1:7);
Ar10 = info.x10Ar(1:7);
fo100 = info.x100fo(1:7);
Ar100 = info.x100Ar(1:7);

fo10CD = info.x10CDfo(1:7);
CD10 = info.x10CD(1:7);
fo100CD = info.x100CDfo(1:7);
CD100 = info.x100CD(1:7);

info.FDW = info.ID; info.FL = info.ID; info.FW = info.ID; info.maxTheta = info.ID; info.startTime = info.ID; info.endTime = info.ID;
%%
for i = 1:length(filenames)
    clear x_distance;
    filename = filenames{i};
    ID = split(filename,'.'); ID = ID{1}; 
    fprintf(ID);
    foil = 0;
    d = 4;
    Case = info(info.ID == convertCharsToStrings(ID),:);
    if Case.foil
        foil = Case.foil;
    end
    fprintf(['oil = ', num2str(foil)]);
    if Case.deq_mm_
        d = Case.deq_mm_;
    end
    fprintf(['d = ', num2str(d), ' mm']);
    % calculate Ar
    if length(ID) == 1
        density_bubble = density_air;
        Ar = Ar10(1);
        Cd = CD10(1);
        trajPath = fullfile(trajInfoPath,['NewAirCase',ID,'.fig']);
    elseif ID(1:3) == '100'
        density_bubble = density_air * (1-foil) + density_100 * foil;
        Ar = interp1(fo100,Ar100,foil,'linear');
        Cd = interp1(fo100CD,CD100,foil,'linear');
        trajPath = fullfile(trajInfoPath,[ID, '.fig']);
    elseif ID(1:2) == '10'
        density_bubble = density_air * (1-foil) + density_10 * foil;
        Ar = interp1(fo10,Ar10,foil,'linear');
        Cd = interp1(fo10CD,CD10,foil,'linear');
        trajPath = fullfile(trajInfoPath,[ID, '.fig']);
    end
    
    fig = openfig(trajPath);
    dataObjs = findobj(fig,'-property','YData');
    x_distance = dataObjs(1).XData;
    close(fig);
    
    fprintf(['Ar = ', num2str(Ar)]);
    fprintf(['density bubble =', num2str(density_bubble), ' kg/m^3']);
    fprintf(['Cd = ', num2str(Cd)]);
    % calculate Cm
    e_cal = sqrt(1- Ar^(-2));
    alpha_0 = 2 / e_cal ^ 3 * (e_cal - sqrt(1 - e_cal^2) * asin(e_cal));
    Cm = alpha_0/(2 - alpha_0);
    fprintf(['CM = ', num2str(Cm)]);
    % calculate s array
    
    data = readtable(filename);
    x = data.x_mm_/1000; u = data.u_mm_s_/1000;
    y = data.y_mm_/1000; v = data.v / 1000;
    z = data.z_mm_/1000; w = data.w / 1000;
    
    list = find(z>0.175);
    if length(list) == 0
        top = length(z);
    else
        top = list(1);
    end
    x = x(1:top); y = y(1:top); z = z(1:top);
    u = u(1:top); v = v(1:top); w = w(1:top);
    speed = sqrt(u.^2 + v.^2 + w.^2);
    
    L = length(x);
    s = zeros([L, 1]);
    for j = 2:L
        s(j) = sqrt((x(j)-x(j-1))^2 + (y(j) - y(j-1))^2 + (z(j) - z(j-1))^2);
    end
    s = cumsum(s);
    
    % calculate r array
    r = [x,y,z];
    
    % create t array
    L = L - 2;
    t = zeros([L,3]);
    for j = 1: L
        t(j,:) = (r(j+2,:)-r(j,:))/(s(j+2) - s(j));
    end
    
    % create dt / ds array
    L = L - 2;
    dtds = zeros([L,3]);
    for j = 1:L
        dtds(j,:) = (t(j+2,:) - t(j,:))/(s(j + 3) - s(j + 1));
    end
    
    % create n array
    n = zeros([L,3]);
    for j = 1:L
        n(j,:) = dtds(j,:)/norm(dtds(j,:));
    end
    
    % create b array
    b = zeros([L,3]);
    for j = 1:L
        b(j,:) = cross(t(j+1,:), n(j,:));
    end
    
    % create kappa array
    kappa = zeros([L,1]);
    for j = 1:L
        kappa(j) = norm(dtds(j,:));
    end
    
    % calculate gt gb and gn array
    g = [0, 0, -9.8];
    gt = zeros([L,1]); gn = zeros([L,1]); gb = gn;
    for j = 1:L
        gt(j) = dot(g, t(j+1,:)/norm(t(j+1,:)));
        gn(j) = dot(g, n(j,:)/norm(n(j,:)));
        gb(j) = dot(g, b(j,:)/norm(b(j,:)));
    end
    
    FB1 = (density_bubble - density_w) * pi / 6 * (d/1000)^3 * gt;
    FB2 = (density_bubble - density_w) * pi / 6 * (d/1000)^3 * gn;
    
    %calculate Ft, Fn, Fb
    Ft = zeros([L,1]); Fn = Ft; Fb = Fn; Fd = Ft;
    for j = 1:L
        Ft(j) = (density_bubble + Cm * density_w) * pi / 6  * (d/1000)^ 3 * (s(j+1) + s(j+3) - 2*s(j+2))/(dt)^2 ...
            -(density_bubble - density_w) * pi / 6 * (d/1000)^3 * gt(j);
        Fn(j) = (density_bubble + Cm * density_w) * pi / 6  * (d/1000)^ 3 * kappa(j) * ...
        ((s(j+3) - s(j+1))/(2*dt))^2 - (density_bubble - density_w) * pi / 6 * (d/1000)^3 * gn(j);
        Fb(j) =  -(density_bubble - density_w) * pi / 6 * (d/1000)^3 * gb(j);
        Fd(j) = -Cd * pi * (d/1000)^2/8 *density_w * ((s(j+3) - s(j+1))/(2*dt))^2;
    end
    Fvd = Ft - Fd;
    Fv = sqrt(Fvd.^2 + Fn.^2 + Fb.^2);
    tanPhi = Fvd./sqrt(Fn.^2 + Fb.^2);
    FL = sqrt(Fn.^2 + Fb.^2);
    Phi = atan(tanPhi);
    the = abs(atan(abs(FB2./FB1)));
    plot_t = [1:length(x)]/200;
    plot_t = plot_t(3:end-2); plot_t = plot_t';
    
    x_distance = x_distance(3:end-2);
    speed = speed(3:end-2);
    
    figure('Position',[10,10,900,900])
    yyaxis left;
    plot(plot_t,Fvd); hold on;
    plot(plot_t,Fv); hold on;
    plot(plot_t,FL); hold on;
    yyaxis right;
    plot(plot_t,the); hold off;
    legend('FVD','FV','FL','theta');
   
      % read ginputs until a mouse right-button occurs
    [tMin,~,button] = ginput(1)
    [tMax,~,button] = ginput(1)
    
    MinIdx = min(find(plot_t > tMin));
    MaxIdx = max(find(plot_t < tMax));
    Fvd_mean = mean(Fvd(MinIdx:MaxIdx));
    Fv_mean = mean(Fv(MinIdx:MaxIdx));
    FL_mean = mean(FL(MinIdx:MaxIdx));
    maxTheta = max(the(MinIdx:MaxIdx));
    
    iRow = find(strcmp(Cases.Case, ID)==1);
    if ~isempty(iRow)
       Cases.start_T(iRow) = tMin;
       Cases.end_T(iRow) = tMax;
       Cases.Fvd(iRow) = Fvd_mean;
       Cases.Fv(iRow) = Fv_mean;
       Cases.FL(iRow) = FL_mean;
       Cases.maxTheta(iRow) = maxTheta;
    end
    close all;
end
writetable(Cases,'info.csv','Delimiter',',');
