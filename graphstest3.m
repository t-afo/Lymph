clear
clc
%% For positive pressure
Dn = csvread('Dalln00positive.csv');
Qn = csvread('Qalln200postive.csv');
pn = csvread('palln200positive.csv');
Rvn = csvread('Rvalln200positive.csv');
tn = csvread('timen200positive.csv')';

N = 4;
pa = 2275;
pb = 2075;
pe = 2275;

pan = pa * ones(1,length(pn));
pbn = pb * ones(1,length(pn));

%removing repeats
Qn = [Qn(1:N,:); Qn(2*N,:)];
Rvn = [Rvn(1:N,:); Rvn(2*N,:)];
pn = [pn(1:N,:);pbn;pan;pn(N+1:2*N,:)];

%arranging
for i = 1:N+1
    deltapn(i,:) = pn(N+1+i,:) - pn(i,:);   
end

deltapn = deltapn(:,1:end);

figure(1) %Diameter vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 1 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Dn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Diameter $D$','Interpreter','latex')
legend('Lymphangion 1','Lymphangion 2','Lymphangion 3','Lymphangion 4')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Dntn200positive','epsc')

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

figure(2) %Pressure vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, pn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Pressure $p$','Interpreter','latex')
legend('$p_{11}$','$p_{21}$','$p_{31}$','$p_{41}$','$p_{b}$','$p_{a}$','$p_{12}$','$p_{22}$','$p_{32}$','$p_{42}$','Interpreter','latex')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 pb-100 pa+100]);

saveas(gcf,'pntn200positive','epsc')

figure(3) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Qn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 0.000045 0.0000485]);

saveas(gcf,'Qntn200positive','epsc')

%% For negative pressure
Dn = csvread('Dalln1000negative.csv');
Qn = csvread('Qalln1000negative.csv');
pn = csvread('palln1000negative.csv');
Rvn = csvread('Rvalln1000negative.csv');
tn = csvread('timen1000negative.csv')';

N = 4;
pa = 2275;
pb = 3275;
pe = 2275;

pan = pa * ones(1,length(pn));
pbn = pb * ones(1,length(pn));

%removing repeats
Qn = [Qn(1:N,:); Qn(2*N,:)];
Rvn = [Rvn(1:N,:); Rvn(2*N,:)];
pn = [pn(1:N,:);pbn;pan;pn(N+1:2*N,:)];

%arranging
for i = 1:N+1
    deltapn(i,:) = pn(N+1+i,:) - pn(i,:);   
end

deltapn = deltapn(:,1:end);

figure(1) %Diameter vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 1 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Dn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Diameter $D$','Interpreter','latex')
legend('Lymphangion 1','Lymphangion 2','Lymphangion 3','Lymphangion 4')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Dntn1000negative','epsc')

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

figure(2) %Pressure vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, pn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Pressure $p$','Interpreter','latex')
legend('$p_{11}$','$p_{21}$','$p_{31}$','$p_{41}$','$p_{b}$','$p_{a}$','$p_{12}$','$p_{22}$','$p_{32}$','$p_{42}$','Interpreter','latex')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 pa-100 pb+100]);

saveas(gcf,'pntn1000negative','epsc')

figure(3) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Qn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 -0.00003 0]);

saveas(gcf,'Qntn1000negative','epsc')

%% For negative pressure
Dn = csvread('Dallnfailure.csv');
Qn = csvread('Qallnfailure.csv');
pn = csvread('pallnfailure.csv');
Rvn = csvread('Rvallnfailure.csv');
tn = csvread('timenfailure.csv')';

N = 4;
pa = 2275;
pb = 2275 + 20000;
pe = 2275;

pan = pa * ones(1,length(pn));
pbn = pb * ones(1,length(pn));

%removing repeats
Qn = [Qn(1:N,:); Qn(2*N,:)];
Rvn = [Rvn(1:N,:); Rvn(2*N,:)];
pn = [pn(1:N,:);pbn;pan;pn(N+1:2*N,:)];

%arranging
for i = 1:N+1
    deltapn(i,:) = pn(N+1+i,:) - pn(i,:);   
end

deltapn = deltapn(:,1:end);

figure(1) %Diameter vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 1 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Dn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Diameter $D$','Interpreter','latex')
legend('Lymphangion 1','Lymphangion 2','Lymphangion 3','Lymphangion 4')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Dntnfailure','epsc')

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

figure(2) %Pressure vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, pn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Pressure $p$','Interpreter','latex')
legend('$p_{11}$','$p_{21}$','$p_{31}$','$p_{41}$','$p_{b}$','$p_{a}$','$p_{12}$','$p_{22}$','$p_{32}$','$p_{42}$','Interpreter','latex')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

%axis([66 76 pa-100 pb+100]);

saveas(gcf,'pntnfailure','epsc')

figure(3) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Qn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([0 100 -0.0008 0.00025]);

saveas(gcf,'Qntnfailure','epsc')
