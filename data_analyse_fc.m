part = ["CEDRIC", "DYLAN", "FREDERIC", "PASCAL", "PIERREA", "PIERREL", "RENE", "SEBASTIEN"];

mf_obj = MF_BS_tool_inter;
mf_obj.nwt = 3;
mf_obj.method_mrq = [1 2];
mf_obj.j1 = 2;
mf_obj.j2 = 10;
q = build_q_log (0.01, 5, 10);
q = q(q>=0) ;
mf_obj.q = q;
mf_obj.cum = 3;
mf_obj.gamint = 1.5;
mf_obj.fig_num = 100;
mf_obj.verbosity = 1;

l_q = [];
l_zq = [];
l_hq = [];
l_Dq = [];

for i=1:8
    load(part(i));
    data = data_csv.FC_bpm_ ;
    mf_obj.analyze (data);
    t_lwt = mf_obj.est.LWT.t;
    lsd_lwt = mf_obj.logstat.LWT.est;
    zid = mf_obj.get_zid ();  % Indices of zeta(q)
    hid = mf_obj.get_hid ();  % Indices of h(q)
    Did = mf_obj.get_Did ();  % Indices of D(q)
    
    zq = mf_obj.est.LWT.t(zid);  % Estimates of zeta(q)
    hq = mf_obj.est.LWT.t(hid);  % Estimates of h(q)
    Dq = mf_obj.est.LWT.t(Did);  % Estimates of D(q)
    
    l_q = [l_q ; q];
    l_zq = [l_zq ; zq];
    l_hq = [l_hq ; hq];
    l_Dq = [l_Dq ; Dq];
end

close all

newcolors = [0.83 0.14 0.14
             1.00 0.54 0.00
             0.47 0.25 0.80
             0.25 0.80 0.54
             0.54 0.80 0.25
             0.80 0.25 0.47
             0.00 0.54 1.00
             0.00 1.00 0.54];

figure(1)
hold on
colororder(newcolors)
for i=1:8
    load(part(i));
    data = data_csv.FC_bpm_ ;
    plot(data)
end
grid on
legend(part)
title('Fréquence cardiaque des coureurs marathoniens');
xlabel('Temps')
ylabel('Fréquence Cardiaque bpm')
hold off

figure(2)
hold on
colororder(newcolors)
for i=1:8
    plot (l_q(i,:), l_zq(i,:), 'Linewidth', 2)
end
grid on
legend(part)
title('Scale Function')
xlabel ('q')
ylabel ('z(q)')
hold off

figure(3)
hold on
colororder(newcolors)
for i=1:8
    h = (l_hq(i,:)<=2.1);
    plot (l_hq(i,h), l_Dq(i,h), 'Linewidth', 2)
end
grid on
a = 1.3 ;
axis([a a+1.5 0 1.2]);
legend(part)
title('Multifractal spetrum')
xlabel ('h')
ylabel ('D(h)')
hold off