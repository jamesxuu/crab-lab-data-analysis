%% Load data
% clear; close all;
name = '35_1.0_control4_1';
path = ['fbk_clean/', name, '.mat'];
exp_fbk = load(path);
exp_load = exp_fbk.fbk.dxl_present_load;
exp_load = exp_load/1000*1.4;
exp_position = exp_fbk.fbk.dxl_present_load;
exp_time = linspace(0, 3, size(exp_load,2));

%% Load calibration data
name = '35_1.0_control1_calibrate';
path = ['fbk_clean/', name, '.mat'];
calib_fbk = load(path);
calib_load = calib_fbk.fbk.dxl_present_load;
calib_load = calib_load/1000*1.4;

%% External torque / tension
external_load = exp_load - calib_load;

external_load = exp_load;
external_load(1:8,:) = exp_load(1:8,:) - calib_load(1:8,:);
external_load(9:14,:) = exp_load(9:14,:);

tension = external_load/0.010;

%% Plot raw load
figure;
set(gcf,'color','w');
title('Net Torque');

subplot(2,4,2);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,1), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
xlabel('Gait cycle');
ylabel('Joint angle (deg)');
title('Joint #1 (head)');

yyaxis right;
plot(exp_time, exp_load(1,:), 'r-');
plot(exp_time, exp_load(2,:), 'b-');
ylim([-0.5 0.8]);
ylabel('Torque (N\cdotm)');


subplot(2,4,3);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,2), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #2');

yyaxis right;
plot(exp_time, exp_load(3,:), 'r-');
plot(exp_time, exp_load(4,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,4);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,3), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #3');

yyaxis right;
plot(exp_time, exp_load(5,:), 'r-');
plot(exp_time, exp_load(6,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,5);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,4), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #4');

yyaxis right;
plot(exp_time, exp_load(7,:), 'r-');
plot(exp_time, exp_load(8,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,6);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,5), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #5');

yyaxis right;
plot(exp_time, exp_load(9,:), 'r-');
plot(exp_time, exp_load(10,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,7);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,6), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #6');

yyaxis right;
plot(exp_time, exp_load(11,:), 'r-');
plot(exp_time, exp_load(12,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,8);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,7), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #7 (Tail)');

yyaxis right;
plot(exp_time, exp_load(13,:), 'r-');
plot(exp_time, exp_load(14,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


%% Plot calibration load
figure;
set(gcf,'color','w');
title('Calibrated Torque');

subplot(2,4,2);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,1), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
xlabel('Gait cycle');
ylabel('Joint angle (deg)');
title('Joint #1 (head)');

yyaxis right;
plot(exp_time, calib_load(1,:), 'r-');
plot(exp_time, calib_load(2,:), 'b-');
ylim([-0.5 0.8]);
ylabel('Torque (N\cdotm)');


subplot(2,4,3);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,2), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #2');

yyaxis right;
plot(exp_time, calib_load(3,:), 'r-');
plot(exp_time, calib_load(4,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,4);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,3), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #3');

yyaxis right;
plot(exp_time, calib_load(5,:), 'r-');
plot(exp_time, calib_load(6,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,5);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,4), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #4');

yyaxis right;
plot(exp_time, calib_load(7,:), 'r-');
plot(exp_time, calib_load(8,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,6);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,5), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #5');

yyaxis right;
plot(exp_time, calib_load(9,:), 'r-');
plot(exp_time, calib_load(10,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,7);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,6), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #6');

yyaxis right;
plot(exp_time, calib_load(11,:), 'r-');
plot(exp_time, calib_load(12,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,8);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,7), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #7 (Tail)');

yyaxis right;
plot(exp_time, calib_load(13,:), 'r-');
plot(exp_time, calib_load(14,:), 'b-');
ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');


%% Plot external load / tension
figure;
set(gcf,'color','w');
title('Calibrated Torque');

subplot(2,4,2);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,1), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
xlabel('Gait cycle');
ylabel('Joint angle (deg)');
title('Joint #1 (head)');

yyaxis right;
plot(exp_time, external_load(1,:), 'r-');
plot(exp_time, external_load(2,:), 'b-');
ylim([-0.2 0.6]);
ylabel('Torque (N\cdotm)');


subplot(2,4,3);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,2), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #2');

yyaxis right;
plot(exp_time, external_load(3,:), 'r-');
plot(exp_time, external_load(4,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,4);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,3), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #3');

yyaxis right;
plot(exp_time, external_load(5,:), 'r-');
plot(exp_time, external_load(6,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,5);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,4), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #4');

yyaxis right;
plot(exp_time, external_load(7,:), 'r-');
plot(exp_time, external_load(8,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,6);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,5), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #5');

yyaxis right;
plot(exp_time, external_load(9,:), 'r-');
plot(exp_time, external_load(10,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,7);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,6), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #6');

yyaxis right;
plot(exp_time, external_load(11,:), 'r-');
plot(exp_time, external_load(12,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,8);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(time_joint_angle, joint_angle(:,7), 'k--');
xlim([0 3]);
ylim([-90 90]);
yticks([-90,-45,0,45,90]);
% xlabel('Gait cycle');
% ylabel('Joint angle (deg)');
title('Joint #7 (Tail)');

yyaxis right;
plot(exp_time, external_load(13,:), 'r-');
plot(exp_time, external_load(14,:), 'b-');
ylim([-0.2 0.6]);
% ylabel('Torque (N\cdotm)');