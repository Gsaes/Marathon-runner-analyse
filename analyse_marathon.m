load DYLAN
figure(1)

%subplot(131)
plot(data_csv.FC_bpm_,'b','linewidth',1.5)
set(gca, 'FontName', 'Arial')
set(gca, 'FontSize', 26)
set(gca, 'LineWidth', 2.0)
%title('Heart Bate')
xlabel('Temps (signal échantillonné à 0,1 s)', 'FontSize', 32)
%ylabel('Battements par minute (bpm)')
grid on

subplot(132)
plot(2*data_csv.CadenceDeCourse_Pied)
title('Cadence')
xlabel('Temps (en 0.1s)')
ylabel('Pas par minute (ppm)')
grid on

subplot(133)
plot(data_csv.Acc_l_ration_m_s__)
title('Accelération')
xlabel('Temps (en 0.1s)')
ylabel('Accélération (m.s^-2)')
grid on

data = data_csv.FC_bpm_;
seuil = fix(length(data).*0.25) ;
data = data(seuil:end);



mf_obj = MF_BS_tool_inter;
mf_obj.method_mrq = [1 2];
mf_obj.nwt = 3;
mf_obj.gamint = 0;
mf_obj.p = 1 ;
mf_obj.j1      = 8;
mf_obj.j2      = 11;
q = build_q_log (0.01, 10, 30);
%q = q(q>=0) ;
mf_obj.q = q ;
mf_obj.cum     = 3;
mf_obj.fig_num = 200;
mf_obj.verbosity = 1;
mf_obj.analyze (data)


[dwt, lwt] = DxPx1d(data, mf_obj.est.LWT.param_est);
dwt = dwt.value ;
lwt = lwt.value ;
n_dwt = length(dwt) ;
n_lwt = length(lwt) ;

%dwt{10}(13)=1;
%dwt{9} = dwt{9}(abs(dwt{9})<=4);
hmin_dwt = [] ;
for i=1:n_dwt
    hmin_dwt = [hmin_dwt log2(max(abs(dwt{i})))] ;
end

j1min = 6 ;
j1max = 12 ;
tab1 = j1min:j1max ;
t1 = linspace(j1min,j1max,1000);
a1 = polyfit(7:11,hmin_dwt(7:11),1) ;
y1 = a1(1)*t1+a1(2) ;


figure(1)
hold on
plot(tab1,hmin_dwt(tab1),'+--')
plot(t1,y1)
legend('log-log representation', 'Linear Regression')
title('Estimation of hmin (DWT)')
text(11,2,num2str(a1(1)),'FontSize',16,'Color','r')
xlabel('j')
ylabel('Log_2 sup|c(j,k)|')
grid on
axis([6 12 0 4])
% 
% %lwt{8}(370)=6;
% hmin_lwt = [] ;
% for i=1:n_lwt
%     hmin_lwt = [hmin_lwt log2(max(abs(lwt{i})))] ;
% end
% 
% j2min = 7 ;
% j2max = 12 ;
% tab2 = j2min:j2max ;
% t2 = linspace(j2min,j2max,1000);
% a2 = polyfit(tab2,hmin_lwt(tab2),1) ;
% y2 = a2(1)*t2+a2(2) ;
% 
% figure(2)
% hold on
% plot(tab2,hmin_lwt(tab2),'+--')
% plot(t2,y2)
% legend('log-log representation', 'Linear Regression')
% title('Estimation of hmin (DWT)')
% text(11,2.2,num2str(a2(1)),'FontSize',16,'Color','r')
% xlabel('j')
% ylabel('Log_2 sup|c(j,k)|')
% grid on
%axis([3 9 1 3])

part = ["M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8"];
hminFC = [-0.2768, -0.0063, -0.0039, -0.1633, -0.24338, -0.3296, 0.1099, -0.53803];
%hminIntFC = [0.76987, 1.1758, 0.82144, 0.8638, 0.8803, 0.74094, 0.94595, 0.52444];
hminCad = [-0.2111, -0.3014, -0.1898, -0.3671, -0.4215, -0.3487, -0.1132, -0.4154];
hminIntCad = [0.78894, 0.69865, 0.8102, 0.63285, 0.57853, 0.65133, 0.88681, 0.58464];

hminAcc = [-1.0646, -1.3485, -1.0728, -1.1450, -1.2592, -1.1650, -1.0267, -1.2307];
hminIntAcc = [0.43542, 0.1515, 0.42718, 0.355, 0.2408, 0.33501, 0.47326, 0.26926];

c1FC = [0.8099 0.4564, 0.6856, 0.6938, 0.5835, 0.5809, 0.5652, 0.3382];
c1IntCad = [0.96008, 0.8943, 0.8838, 0.84578, 0.97042, 0.91957, 1.046, 0.9374];
c1IntAcc = [0.643, 0.5703, 0.75294, 0.6112, 0.77317, 0.65362, 0.78859, 0.59972];


figure(4)
plot(hminIntCad,c1IntCad,'black+')
xlabel('H_{min}')
ylabel('c1')
for i=1:8
    text(hminIntCad(i),c1IntCad(i)+0.005,part(i))
end
grid on
axis([0 1 0 1.1])


hminFC = [-0.2768, -0.0063, -0.0039, -0.1633, -0.24338, -0.3296, -0.11399, -0.53803];
c1FC = [0.8099, 0.4564, 0.6856, 0.6938, 0.5835, 0.5809, 0.5652, 0.3382];
hmindebFC = [-0.2768, -0.0063, 0.16218, -0.16333, -0.24338, -0.11314, 0.0254, -0.53803];
c1debFC = [0.72876, 0.48297, 0.62492, 0.58453, 0.44972, 0.5754, 0.58412, 0.3196];
hminfinFC = [-0.03848, 0.19832, -0.0039, -0.02068, -0.15755, -0.3296, -0.11399,-0.36714];
c1finFC = [0.86001, 0.4828, 0.71458, 0.70097, 0.63112, 0.55411, 0.4979, 0.4557];


figure(3)
plot(hminFC,c1FC,'black+','LineWidth',5.5)
set(gca, 'FontName', 'Arial')
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 2.0)
xlabel('H_{min}')
ylabel('c1')
for i=1:8
    text(hminFC(i),c1FC(i)+0.07,part(i), 'FontSize',22)
end
grid on
axis([-0.6 0.1 0 1])

col = [	'#0072BD'; 	'#D95319'; 	'#EDB120'; '#7E2F8E'; 	'#77AC30'; 	'#4DBEEE'; '#A2142F'; '#00FF00'] ;
figure(7)
hold on
set(gca, 'FontName', 'Arial')
set(gca, 'FontSize', 16)
%set(gca, 'LineWidth', 1.0)
xlabel('H_{min}')
ylabel('c1')

for i=1:8
    plot(hmindebFC(i), c1debFC(i), '+', 'Color', col(i,:), 'LineWidth',5.5)
    plot(hminfinFC(i), c1finFC(i), '+', 'Color', col(i,:), 'LineWidth',5.5)
    if i==1 
        text(hmindebFC(i)-0.1, c1debFC(i), part(i), 'Color',col(i,:),'FontSize',22)
    elseif i==2
        text(hmindebFC(i)+0.05, c1debFC(i)-0.05, part(i), 'Color',col(i,:),'FontSize',22)
    elseif i==3 
        text(hmindebFC(i)+0.04, c1debFC(i)+0.02, part(i), 'Color',col(i,:),'FontSize',22)
    elseif i==4 
        text(hmindebFC(i)+0.07, c1debFC(i)+0.15, part(i),'Color',col(i,:),'FontSize',22)
    elseif i==5 
        text(hmindebFC(i), c1debFC(i)-0.08, part(i),'Color',col(i,:),'FontSize',22)
    elseif i==6
        text(hminfinFC(i)-0.05, c1finFC(i), part(i), 'Color',col(i,:),'FontSize',22)
    elseif i==8
        text(hmindebFC(i)-0.02, c1debFC(i)-0.05, part(i), 'Color',col(i,:),'FontSize',22)
    else
        text(hmindebFC(i), c1debFC(i)-0.05, part(i), 'Color',col(i,:),'FontSize',22)
    end
    %text(hminfinFC(i), c1finFC(i)-0.05, part(i), 'Color', 'r','FontSize',50)
    quiver(hmindebFC(i), c1debFC(i), hminfinFC(i)-hmindebFC(i), c1finFC(i)-c1debFC(i), 'Color',col(i,:),'LineWidth',1.5)
end

grid on
axis([-0.6 0.3 0 1])
hold off


