clear
clc
%%
%Resistance over pressure
Rvmin = 600.0; %min. valve resistance
Rvmax = 1.2 * 10^7; %max. valve resistance
sopen = 4.9 * 10^-2; %valve opening slope
sopen1 = 2.9 * 10^-2;
sopen2 = 6.9 * 10^-2;
sfail = 0.04; %valve failure 
popen = -70.0; %valve opening pressure
popen1 = -20;
popen2 = -120;
pfail = -1.8 * 10^4; %valve failure pressure

pressure = linspace(-20000,200,1000);  
%%
%changing sopen

siglimit = 1 ./ (1 + exp(sopen * (pressure - popen)));
sigfailure = 1 ./ (1 + exp(-sfail * (pressure - pfail)));

siglimit1 = 1 ./ (1 + exp(sopen1 * (pressure - popen)));

siglimit2 = 1 ./ (1 + exp(sopen2 * (pressure - popen)));
   
resistance = Rvmin + Rvmax * (siglimit + sigfailure - 1);
resistance1 = Rvmin + Rvmax * (siglimit1 + sigfailure - 1);
resistance2 = Rvmin + Rvmax * (siglimit2 + sigfailure - 1);

figure(1) %Flowrate vs time

newcolors = [0 0 0; 0 0 1; 1 0 0; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(pressure, resistance, 'LineWidth', 1.5)
hold on

xlabel('Pressure difference $\Delta p$ (dyn cm$^{-2}$)','Interpreter','latex')
ylabel('Resistance $R_{v_n}$ (dyn cm$^2$/ml s$^{-1}$)','Interpreter','latex')
%legend('$s_{open} = 4.9 * 10^-2$','$s_{open} = 2.9 * 10^-2$','$s_{open} = 6.9 * 10^-2$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rvnpnfail','epsc')
hold off

%%
%changing sopen

siglimit = 1 ./ (1 + exp(sopen * (pressure - popen)));
sigfailure = 1 ./ (1 + exp(-sfail * (pressure - pfail)));

siglimit1 = 1 ./ (1 + exp(sopen1 * (pressure - popen)));

siglimit2 = 1 ./ (1 + exp(sopen2 * (pressure - popen)));
   
resistance = Rvmin + Rvmax * (siglimit + sigfailure - 1);
resistance1 = Rvmin + Rvmax * (siglimit1 + sigfailure - 1);
resistance2 = Rvmin + Rvmax * (siglimit2 + sigfailure - 1);

figure(1) %Flowrate vs time

newcolors = [0 0 0; 0 0 1; 1 0 0; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(pressure, resistance, 'LineWidth', 1.5)
hold on
plot(pressure, resistance1, 'LineWidth', 1.5)
plot(pressure, resistance2, 'LineWidth', 1.5)

xlabel('Pressure difference $\Delta p$ (dyn cm$^{-2}$)','Interpreter','latex')
ylabel('Resistance $R_{v_n}$ (dyn cm$^2$/ml s$^{-1}$)','Interpreter','latex')
legend('$s_{open} = 4.9 * 10^-2$','$s_{open} = 2.9 * 10^-2$','$s_{open} = 6.9 * 10^-2$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rvnpnsopen','epsc')
hold off

%%
%changing popen

siglimit1 = 1 ./ (1 + exp(sopen * (pressure - popen1)));

siglimit2 = 1 ./ (1 + exp(sopen * (pressure - popen2)));
   
resistance = Rvmin + Rvmax * (siglimit + sigfailure - 1);
resistance1 = Rvmin + Rvmax * (siglimit1 + sigfailure - 1);
resistance2 = Rvmin + Rvmax * (siglimit2 + sigfailure - 1);


figure(2) %Flowrate vs time

newcolors = [0 0 0; 0 0 1; 1 0 0; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(pressure, resistance, 'LineWidth', 1.5)
hold on
plot(pressure, resistance1, 'LineWidth', 1.5)
plot(pressure, resistance2, 'LineWidth', 1.5)


xlabel('Pressure difference $\Delta p$ (dyn cm$^{-2}$)','Interpreter','latex')
ylabel('Resistance $R_{v_n}$ (dyn cm$^2$/ml s$^{-1}$)','Interpreter','latex')
legend('$p_{open} = -70.0$','$p_{open} = -20.0$','$p_{open} = -120.0$','Interpreter','latex')
axis
grid on
%axis([0 120 -0.00004 0.00008]);

saveas(gcf,'Rvnpnpopen','epsc')
hold off

%%
Pd = [50, 75, 100, 125]';
Dd = [0.025, 0.022, 0.019, 0.016]';
pe = 2275;

Dn = csvread('Dalln.csv');
tn = csvread('timen.csv')';
N = 4;
t0 = [0.5, 1, 1.5, 2]';

for i = 1:length(tn)
    for j = 1:N
        if tn(i) > t0(j)
            M(j,i) = 3.5;
        else
            M(j,i) = 0;
        end
    end
end

for i = 1:N
    fpassive(i,:) = Pd(i) * (exp(Dn(i,:)./Dd(i,:)) - (Dd(i)./Dn(i,:)).^3);
    factive(i,:)  = M(i,:)./Dn(i,:) .* (1 - cos(2 * pi * 0.5 * (tn - t0(i))));
    ptransmural(i,:) = fpassive(i,:) + factive(i,:);
end

figure(3) %Flowrate vs time

newcolors = [0 0 0; 0 0 1; 1 0 0; 0 1 0; 0 0 0; 0 0 0; 1 1 0; 0 1 1; 1 0.2 1; 1 0 0.5]; % k,r,b,g,y,c
colororder(newcolors)

plot(tn, fpassive(1,:), 'LineWidth', 1.5)
hold on
plot(tn, factive(1,:), 'LineWidth', 1.5)
plot(tn, ptransmural(1,:), 'LineWidth', 1.5)

xlabel('Time $t$ $(s)$','Interpreter','latex')
ylabel('Pressure $p$ (dyn cm$^{-2}$)','Interpreter','latex')
legend('Passive component','Active component','Transmural pressure','Interpreter','latex')
axis
grid on
axis([50 60 0 400]);

saveas(gcf,'pcomponents','epsc')
hold off




