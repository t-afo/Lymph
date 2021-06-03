clear
clc

N = 4;

D = csvread('Dall1.csv');
Q = csvread('Qall1.csv');
p = csvread('pall1.csv');
Rv = csvread('Rvall1.csv');
t = csvread('time1.csv')';

Dn = csvread('Dalln.csv');
Qn = csvread('Qalln.csv');
pn = csvread('palln.csv');
Rvn = csvread('Rvalln.csv');
tn = csvread('timen.csv')';

figure(1)


pa = 2275 * ones(1,length(p));
pb = 2375 * ones(1, length(p));
p = [pa;p;pb];

subplot(2,2,1)
plot(t, D) 
deltap = [p(1,:) - p(2,:); p(3,:) - p(4,:)] ;
deltap = deltap(:,2:end);
title("t over D")

subplot(2,2,2)
plot(t, Q)
title("Q over deltap")

subplot(2,2,3)
plot(t(1,2:end), p(:,2:end))
title("t over deltap")

subplot(2,2,4)
plot(deltap(1,:), Rv(1,2:end))
title("deltap over Rv")

figure(2)
pan = 2100 * ones(1,length(pn));
pbn = 3000 * ones(1,length(pn));

Qn = [Qn(1:N,:); Qn(2*N,:)];
Rvn = [Rvn(1:N,:); Rvn(2*N,:)];
pn = [pn(1:N,:);pbn;pan;pn(N+1:2*N,:)];

subplot(2,2,1)
plot(tn, Dn) 
%plot(tn, Qn(1,:))

for i = 1:N+1
    deltapn(i,:) = pn(N+1+i,:) - pn(i,:);   
end
deltap = deltap(1,2:end);
title("t over D")

subplot(2,2,2)
plot(deltapn(3,:), Qn(3,:))
title("Q over deltap")

subplot(2,2,3)
plot(tn, pn)
title("t over deltap")

subplot(2,2,4)
plot(tn, Rvn(1,:))
title("deltap over Rv")














