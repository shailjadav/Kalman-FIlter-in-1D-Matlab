%% Kalman filter in 1D
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shail Jadav
% Contact: shailjadav.github.io
% I believe in sharing, and it's my way to make the world a better place. If this code helps you in any way, consider doing one good thing for the world!
% Enjoy!
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc
%% System
t=0:1/1000:20;
y=10*[ones(1,floor(length(t)/2)) ones(1,floor(length(t)/2) +1)];

v=rand(1,length(t));
v=v-mean(v);
s=y+v;

% Initial Guess 
est=0;
Eest=0.01;

mea=s(1,1);
Emea=var(v);

for i=1:1:length(y)
    mea=s(1,i);
    Kf= Eest/(Eest+Emea);
    est=est + Kf*(mea-est);
    Eest=(1-Kf)*(Eest);
    Data(i,:)=[Kf est Eest];
  
end
figure
plot(t,s,'r')
hold on
plot(t,y,'b','linewidth',2)
plot(t,Data(:,2),'--g','linewidth',2)
%plot(t,smooth(s,100),'y','linewidth',2)
grid minor
xlabel('Time(s)','fontsize',14,'interpreter','latex')
ylabel('Temperature(K)','fontsize',14,'interpreter','latex')
legend({'Measurement with uncertainty','True Value','Kalman estimation'},'fontsize',14,'interpreter','latex')

figure
subplot(211)
stem(t,Data(:,1))
ylim([0 1])
grid minor
xlabel('Time(s)','fontsize',14,'interpreter','latex')
ylabel('Kalman Gain','fontsize',14,'interpreter','latex')

subplot(212)
plot(t,Data(:,2),'linewidth',2)
grid minor
xlabel('Time(s)','fontsize',14,'interpreter','latex')
ylabel('Estimate','fontsize',14,'interpreter','latex')

