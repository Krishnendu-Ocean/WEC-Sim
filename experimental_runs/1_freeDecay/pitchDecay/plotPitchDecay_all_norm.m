%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                        Pitch Decay                               %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

load('pitchDecayCase.mat')
load ./exp/psPitchDecay_norm_postp_mean.mat

%% Plot Exp and WS Data

figure;
%EXP
for i=1:5
    plot(T_mean(i).t_corrected,T_mean(i).y_norm,'-','LineWidth',1.5);hold on
end
set(gca,'ColorOrderIndex',1)
set(gcf, 'Color', 'w');
for i = 1:5     %expRuns
    for j=1:11  %numErrorBar
        ind(j)= find(T_mean(i).t_corrected==T_mean(i).t_error_bar(j));
    end
    errorbar(T_mean(i).t_error_bar,T_mean(i).y_norm(ind(:)),T_mean(i).error_bar_norm,'*'); hold on;
end

% %Linear WS
% hold on
% set(gca,'ColorOrderIndex',1)
% set(gcf, 'Color', 'w');
% for i = 1:length(mcr.cases)
%     load(['./pitchDecay_linear/pitchDecayCase_',num2str(mcr.cases(i),'%2g'),'deg/FOSWEC_Pitch_matlabWorkspace.mat']) 
%     theta = [2,3,5,7,8.4];
%     plot(output.bodies(2).time,output.bodies(2).position(:,5)*180/pi/theta(i),':','LineWidth',1.5);   
%     hold on
% end

%NonLinear WS, platform Cd
hold on
set(gca,'ColorOrderIndex',1)
set(gcf, 'Color', 'w');
for i = 1:length(mcr.cases)
    load(['./pitchDecay_nonlinear/pitchDecayCase_',num2str(mcr.cases(i),'%2g'),'deg/FOSWEC_Pitch_matlabWorkspace.mat']) 
    theta = [2,3,5,7,8.4];
    plot(output.bodies(2).time,output.bodies(2).position(:,5)*180/pi/theta(i),':','LineWidth',1.5);   
    hold on
end

xlabel('t [s]')
ylabel('\theta/\theta_o')
xlim([-0.5 8])
for i = 1:length(theta)
    leg{i} = ['\theta_0 = ' num2str(theta(i),3) '^o'];
end
legend(leg,'location','northeast')
% title(['Pitch Decay Exp, Linear, Nonlinear (cd ',num2str(body(3).viscDrag.cd(5),'%2g'),', c ',num2str(body(3).linearDamping(5),'%2g'),')'])

savefig('pitchDecay_norm_Exp_WS.fig')


%% Plot WS Comparison

figure;
%EXP
load ./exp/psPitchDecay_norm_postp_mean.mat
for i=3
   h1 = plot(T_mean(i).t_corrected,T_mean(i).y_norm,'k-','LineWidth',1.5);hold on
end
set(gca,'ColorOrderIndex',1)
set(gcf, 'Color', 'w');
for i = 3    %expRuns
    for j=1:length(T_mean(3).t_error_bar)  %numErrorBar
        ind(j)= find(T_mean(i).t_corrected==T_mean(i).t_error_bar(j));
    end
    errorbar(T_mean(i).t_error_bar,T_mean(i).y_norm(ind(:)),T_mean(i).error_bar_norm,'k*'); hold on;
end

%Linear WS
hold on
set(gca,'ColorOrderIndex',1)
set(gcf, 'Color', 'w');
for i = 3
    load(['./pitchDecay_linear/pitchDecayCase_',num2str(mcr.cases(i),'%2g'),'deg/FOSWEC_Pitch_matlabWorkspace.mat']) 
    theta = [2,3,5,7,8.4];
   h2 = plot(output.bodies(2).time,output.bodies(2).position(:,5)*180/pi/theta(i),'r-.','LineWidth',1.5);   
    hold on
end

%NonLinear WS, platform Cd
hold on
set(gca,'ColorOrderIndex',1)
set(gcf, 'Color', 'w');
for i = 3
    load(['./pitchDecay_nonlinear/pitchDecayCase_',num2str(mcr.cases(i),'%2g'),'deg/FOSWEC_Pitch_matlabWorkspace.mat']) 
    theta = [2,3,5,7,8.4];
   h3 = plot(output.bodies(2).time,output.bodies(2).position(:,5)*180/pi/theta(i),'b:','LineWidth',1.5);   
    hold on
end

xlabel('t [s]')
ylabel('\theta/\theta_o')
xlim([-0.5 8])
leg = [{'Exp'};{'Linear'};{'NonLinear'}];
% legend([h1 h2 h3],leg,'location','northeast')

legend(leg,'location','northeast')
savefig('pitchDecay_norm_WS_Comp.fig')
