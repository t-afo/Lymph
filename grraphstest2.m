clear
clc
%% For 100 diff

Dn = csvread('Dalln100pe.csv');
Qn = csvread('Qalln100pe.csv');
pn = csvread('palln100pe.csv');
Rvn = csvread('Rvalln100pe.csv');
tn = csvread('timen100pe.csv')';

N = 4;
pa = 2275;
pb = 2575;
pe = 2375;

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

saveas(gcf,'Dntn100pe','epsc')

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

saveas(gcf,'pntn100pe','epsc')

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

saveas(gcf,'Qntn100pe','epsc')

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(deltapn(i,:), Qn(i,:), 'LineWidth', 1.5)
    hold on
end

xlabel('Pressure difference $\Delta p$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rntn100pe','epsc')
hold off
%% For 200 diff

Dn = csvread('Dalln200pe.csv');
Qn = csvread('Qalln200pe.csv');
pn = csvread('palln200pe.csv');
Rvn = csvread('Rvalln200pe.csv');
tn = csvread('timen200pe.csv')';

N = 4;
pa = 2275;
pb = 2575;
pe = 2475;

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

saveas(gcf,'Dntn200pe','epsc')

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

saveas(gcf,'pntn200pe','epsc')

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

saveas(gcf,'Qntn200pe','epsc')

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(Qn(i,:),deltapn(i,:),'LineWidth', 1.5)
    hold on
end

xlabel('Pressure difference $\Delta p$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rntn200pe','epsc')
hold off

%% For 300 diff

Dn = csvread('Dalln300pe.csv');
Qn = csvread('Qalln300pe.csv');
pn = csvread('palln300pe.csv');
Rvn = csvread('Rvalln300pe.csv');
tn = csvread('timen300pe.csv')';

N = 4;
pa = 2275;
pb = 2575;
pe = 2575;

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

saveas(gcf,'Dntn300pe','epsc')

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

saveas(gcf,'pntn300pe','epsc')

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

saveas(gcf,'Qntn300pe','epsc')

figure(4) %Flowrate vs time

newcolors = [1 0 0; 0 0 1; 1 0 1; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

for i  = 1:N+1
    plot(deltapn(i,:), Rvn(i,:), 'LineWidth', 1.5)
    hold on
end

xlabel('Pressure difference $\Delta p$','Interpreter','latex')
ylabel('Flow-rate $Q_n$','Interpreter','latex')
legend('$Q_{1}$','$Q_{2}$','$Q_{3}$','$Q_{4}$','$Q_{5}$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rntn300pe','epsc')
hold off