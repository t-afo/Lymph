clear
clc
%% For 600

Dn = csvread('Dalln600.csv');
Qn = csvread('Qalln600.csv');
pn = csvread('palln600.csv');
Rvn = csvread('Rvalln600.csv');
tn = csvread('timen600.csv')';

N = 4;
pa = 2275;
pb = 2875;
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

saveas(gcf,'Dntn600','epsc')

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

saveas(gcf,'pntn600','epsc')

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

axis([66 76 -0.000025 0]);

saveas(gcf,'Qntn600','epsc')

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(tn, deltapn(i,:), 'LineWidth', 1.5)
    hold on
end

ylabel('Pressure difference $\Delta p$','Interpreter','latex')
xlabel('Time $t$','Interpreter','latex')
legend('$\Delta p_{1}$','$\Delta p_{2}$','$\Delta p_{3}$','$\Delta p_{4}$','$\Delta p_{5}$','Interpreter','latex')
axis
grid on
axis([66 76 -400 0]);

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Rntn600','epsc')
hold off
%% For 300

Dn = csvread('Dalln300.csv');
Qn = csvread('Qalln300.csv');
pn = csvread('palln300.csv');
Rvn = csvread('Rvalln300.csv');
tn = csvread('timen300.csv')';

N = 4;
pa = 2275;
pb = 2575;
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

saveas(gcf,'Dntn300','epsc')

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

saveas(gcf,'pntn300','epsc')

figure(3) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Qn, 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on
axis([0 120 -0.00004 0.00008]);
axis([66 76 -0.000025 0]);

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(tn, deltapn(i,:), 'LineWidth', 1.5)
    hold on
end

ylabel('Pressure difference $\Delta p$','Interpreter','latex')
xlabel('Time $t$','Interpreter','latex')
legend('$\Delta p_{1}$','$\Delta p_{2}$','$\Delta p_{3}$','$\Delta p_{4}$','$\Delta p_{5}$','Interpreter','latex')
axis
grid on
axis([66 76 -200 0]);

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Rntn300','epsc')
hold off
%% For 100

Dn = csvread('Dalln100.csv');
Qn = csvread('Qalln100.csv');
pn = csvread('palln100.csv');
Rvn = csvread('Rvall100.csv');
tn = csvread('timen100.csv')';

N = 4;
pa = 2275;
pb = 2375;
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

xlabel('Time $t$','Interpreter','latex')
ylabel('Diameter $D$','Interpreter','latex')
legend('Lymphangion 1','Lymphangion 2','Lymphangion 3','Lymphangion 4')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Dntn100','epsc')

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

figure(2) %Pressure vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, pn, 'LineWidth', 1.5)

xlabel('Time $t$','Interpreter','latex')
ylabel('Pressure $p$','Interpreter','latex')
legend('$p_{11}$','$p_{21}$','$p_{31}$','$p_{41}$','$p_{b}$','$p_{a}$','$p_{12}$','$p_{22}$','$p_{32}$','$p_{42}$','Interpreter','latex')
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 pa-50 pb+300]);

saveas(gcf,'pntn100','epsc')

figure(3) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, Qn, 'LineWidth', 1.5)

xlabel('Time $t$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

axis([66 76 -0.0000275 0]);

saveas(gcf,'Qntn100','epsc')

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(tn, deltapn(i,:), 'LineWidth', 1.5)
    hold on
end

ylabel('Pressure difference $\Delta p$','Interpreter','latex')
xlabel('Time $t$','Interpreter','latex')
legend('$\Delta p_{1}$','$\Delta p_{2}$','$\Delta p_{3}$','$\Delta p_{4}$','$\Delta p_{5}$','Interpreter','latex')
axis
grid on
axis([66 76 -400 0]);

width = 1000;
height = 300;
set(gcf,'position',[10,10,width,height])

saveas(gcf,'Rntn100','epsc')
hold off