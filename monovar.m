N = 32768 ; 
load PIERREA
data = data_csv.FC_bpm_ ;
data1 = data(1:32768) ;
data2 = data(end-32768:end) ;

mf_obj = MF_BS_tool_inter;
mf_obj.method_mrq = [1 2];
mf_obj.nwt = 3;
mf_obj.gamint = 0;
mf_obj.p = inf ;
mf_obj.j1      = 9;
mf_obj.j2      = 11;
q = build_q_log (0.01, 10, 30);
q = q(q>0) ;
mf_obj.q = q ;
mf_obj.cum     = 3;
mf_obj.fig_num = 200;
mf_obj.verbosity = 1;
mf_obj.analyze (data);
hid = mf_obj.get_hid ();  % Indices of h(q)
Did = mf_obj.get_Did ();  % Indices of D(q)
hq1 = mf_obj.est.LWT.t(hid) ;
Dq1 = mf_obj.est.LWT.t(Did) ;

mf_obj.j1      = 9;
mf_obj.j2      = 11;
q = build_q_log (0.01, 10, 30);
%q = q(q>0) ;
mf_obj.q = q ;
mf_obj.analyze (data1);
hid = mf_obj.get_hid ();  % Indices of h(q)
Did = mf_obj.get_Did ();  % Indices of D(q)
hq2 = mf_obj.est.LWT.t(hid) ;
Dq2 = mf_obj.est.LWT.t(Did) ;

mf_obj.j1      = 8;
mf_obj.j2      = 10;
q = build_q_log (0.01, 10, 30);
q = q(q>0) ;
mf_obj.q = q ;
mf_obj.analyze (data2);
hid = mf_obj.get_hid ();  % Indices of h(q)
Did = mf_obj.get_Did ();  % Indices of D(q)
hq3 = mf_obj.est.LWT.t(hid) ;
Dq3 = mf_obj.est.LWT.t(Did) ;

close all

figure(1)
hold on
plot(hq1,Dq1)
plot(hq2,Dq2)
plot(hq3,Dq3)
grid on
title('Spectre multifractal sur la fréquence cardiaque d''un coureur marathonien')
xlabel('h')
ylabel('D(h)')
axis([0 1 0 1])
legend('Totalité de la course','Début de la course','Fin de la course')

Mara = ["SEBASTIEN", "CEDRIC", "DYLAN", "FREDERIC", "PASCAL", "RENE", "PIERREL", "PIERREA"] ;

c1F_debut = [0.61453 0.70706 0.27456 0.588 0.70418 0.65833 0.60076 0.32892];
c1F_fin = [0.61453 0.70706 0.27456 0.588 0.70418 0.65833 0.60076 0.32892];
c2F_debut = [-0.17927 0.29381 0.021776 -0.025648 -0.0338 -0.084502 0.13613 -0.080164];
c2F_fin = [-0.17927 0.29381 0.021776 -0.025648 -0.0338 -0.084502 0.13613 -0.080164];

c1V_debut = [0.36481 0.54418 0.38202 0.41008 0.43868 0.5322 0.55035 0.56101];
c1V_fin = [0.46577 0.54374 0.42145 0.57272 0.362 0.43846 0.47631 0.63496];
c2V_debut = [-0.2122 -0.097368 -0.045716 -0.10962 -0.0093316 -0.02848 0.0036382 -0.17897];
c2V_fin = [-0.13796 -0.088156 -0.096432 -0.11543 -0.1344 -0.044238 -0.10936 -0.19441];

c1A_debut = [0.35047 0.48554 0.33875 0.47372 0.44141 0.52002 0.46929 0.47115] ;
c1A_fin = [0.45939 0.46339 0.47019 0.54634 0.34112 0.43398 0.47169 0.60662] ;
c2A_debut = [-0.17123 -0.069567 -0.097571 -0.039704 -0.0046441 0.025063 -0.083199 -0.23053];
c2A_fin = [-0.12566 -0.094648 -0.051878 -0.093911 -0.11607 -0.016981 -0.099172 -0.16009] ;




figure(2)
hold on 
plot(c1_debut,c2_debut,'+b')
plot(c1_arriv,c2_arriv,'+r')
