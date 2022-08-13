load PASCAL
data1 = data_csv.FC_bpm_ ;
data2 = data_csv.CadenceDeCourse_Pied ;
%data3 = data_csv.CadenceDeCourse_Pied ;

data = {data1,data2};
mo = MF_BS_tool_inter ();
mo.p = inf;
q = build_q_log (0.01, 5, 30);
%q = q(q>-2) ;
%q = q(q<3) ;
mo.q = q ;
mo.cum = 3;
mo.j1 = 9;
mo.j2 = 13;
mo.gamint = 1;
mo.verbosity = 1;
mo.fig_num = 100;
mo.analyze (data);
est_mat = reshape_estimates_GC (mo.est);

data = data1;
mf_obj = MF_BS_tool_inter;
mf_obj.method_mrq = [1 2];
mf_obj.nwt = 3;
mf_obj.gamint = 1;
mf_obj.p = inf ;
mf_obj.j1      = 9;
mf_obj.j2      = 13;
q = build_q_log (0.01, 10, 30);
%q = q(q>-1) ;
mf_obj.q = q ;
mf_obj.cum     = 3;
mf_obj.fig_num = 200;
mf_obj.verbosity = 1;
mf_obj.analyze (data);

hid1 = mf_obj.get_hid ();  % Indices of h(q)
Did1 = mf_obj.get_Did ();  % Indices of D(q)
hq1 = mf_obj.est.LWT.t(hid1);  % Estimates of h(q)
Dq1 = mf_obj.est.LWT.t(Did1);  % Estimates of D(q)


data = data2;
mf_obj = MF_BS_tool_inter;
mf_obj.method_mrq = [1 2];
mf_obj.nwt = 3;
mf_obj.gamint = 1;
mf_obj.p = inf ;
mf_obj.j1      = 7;
mf_obj.j2      = 12;
q = build_q_log (0.01, 10, 30);
%q = q(q>0) ;
mf_obj.q = q ;
mf_obj.cum     = 3;
mf_obj.fig_num = 300;
mf_obj.verbosity = 1;
mf_obj.analyze (data);
hid2 = mf_obj.get_hid ();  % Indices of h(q)
Did2 = mf_obj.get_Did ();  % Indices of D(q)
hq2 = mf_obj.est.LWT.t(hid2);  % Estimates of h(q)
Dq2 = mf_obj.est.LWT.t(Did2);  % Estimates of D(q)

close all

h1 = est_mat.LWT.t.hq(:,:,1);
h2 = est_mat.LWT.t.hq(:,:,2);
Dh1h2 = est_mat.LWT.t.Dq;

figure(1)
surf(h1,h2,Dh1h2)
axis([0.6 2 0.6 1.2 0 1])
grid on
title('Spectre Multifractal bivarié de la primitive Fréquence/Cadence d''un coureur marathonien');
xlabel('h_1')
ylabel('h_2')
zlabel('D(h_1,h_2)')

figure(2)
subplot(121)
plot(hq1,Dq1)
axis([0.6 2 0 1])
grid on
title('Spectre Multifractal de la primitive de la Fréquence Cardiaque d''un coureur marathonien');
xlabel('h_1')
ylabel('D(h_1)')

subplot(122)
plot(hq2,Dq2)
axis([0.6 1.2 0 1])
grid on
title('Spectre Multifractal de la primitive de la Cadence d''un coureur marathonien');
xlabel('h_2')
ylabel('D(h_2)')

nh = length(h1) ;
Dadd =zeros(nh,nh) ;
Dmult =zeros(nh,nh) ;
for i=1:nh
    for j=1:nh
        Dmult(i,j) = Dq1(i)+Dq2(j)-1 ;
        Dadd(i,j) = min(Dq1(i),Dq2(j)) ;
    end
end

figure(3)
subplot(121)
surf(hq1,hq2,abs(Dadd-Dh1h2))
axis([0.5 1.6 0.4 1.2 0 1]);
grid on
title('Différence entre spectre bivarié et min(D(h_1),D(h_2))');
xlabel('h_1')
ylabel('h_2')
zlabel('min(D(h_1),D(h_2))')
subplot(122)
surf(hq1,hq2,abs(Dmult-Dh1h2))
axis([0.5 1.6 0.4 1.2 0 1]);
grid on
title('Différence entre spectre bivarié et D(h_1)+D(h_2)-1');
xlabel('h_1')
ylabel('h_2')
zlabel('D(h_1)+D(h_2)-1')
      
