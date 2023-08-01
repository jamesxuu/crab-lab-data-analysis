%% Load data
% clear; close all;
name = '75_1.0_ctrl2_passiveness0.00_1';
path = ['fbk/', name, '.mat'];
exp_fbk = load(path);
exp_load = exp_fbk.fbk.dxl_present_load;
% exp_load = exp_load/1000*1.4;
exp_position = exp_fbk.fbk.dxl_present_position;
exp_time = exp_fbk.fbk.dxl_present_time;

%% Plot raw load
figure;
set(gcf,'color','w');
title('Raw');

subplot(2,4,2);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(1,:), 'r--');
plot(exp_time, exp_position(2,:), 'b--');
% xlim([0 3]);
xlabel('Gait cycle');
ylabel('Position');
title('Joint #1 (head)');

yyaxis right;
plot(exp_time, exp_load(1,:), 'r-');
plot(exp_time, exp_load(2,:), 'b-');
ylim([-1000 1000]);
ylabel('Torque (percentage)');


subplot(2,4,3);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(3,:), 'r--');
plot(exp_time, exp_position(4,:), 'b--');
% xlim([0 3]);
title('Joint #2 (head)');

yyaxis right;
plot(exp_time, exp_load(3,:), 'r-');
plot(exp_time, exp_load(4,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,4);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(5,:), 'r--');
plot(exp_time, exp_position(6,:), 'b--');
% xlim([0 3]);
title('Joint #3');

yyaxis right;
plot(exp_time, exp_load(5,:), 'r-');
plot(exp_time, exp_load(6,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,5);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(7,:), 'r--');
plot(exp_time, exp_position(8,:), 'b--');
% xlim([0 3]);
title('Joint #4');

yyaxis right;
plot(exp_time, exp_load(7,:), 'r-');
plot(exp_time, exp_load(8,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,6);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(9,:), 'r--');
plot(exp_time, exp_position(10,:), 'b--');
% xlim([0 3]);
title('Joint #5');

yyaxis right;
plot(exp_time, exp_load(9,:), 'r-');
plot(exp_time, exp_load(10,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,7);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(11,:), 'r--');
plot(exp_time, exp_position(12,:), 'b--');
% xlim([0 3]);
title('Joint #6');

yyaxis right;
plot(exp_time, exp_load(11,:), 'r-');
plot(exp_time, exp_load(12,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,8);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(13,:), 'r--');
plot(exp_time, exp_position(14,:), 'b--');
% xlim([0 3]);
title('Joint #7 (Tail)');

yyaxis right;
plot(exp_time, exp_load(13,:), 'r-');
plot(exp_time, exp_load(14,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');

%% Fix problematic fbk
for step = 2:length(exp_time)
    for i = 1:14
        if exp_position(i,step) == 0
            previous = exp_position(i,step-1);
            idx_shift = 1;
            while exp_position(i,step+idx_shift) == 0
                idx_shift = idx_shift + 1;
            end
            next = exp_position(i,step+idx_shift);
            exp_position(i,step) = previous + (next - previous)/(idx_shift+1);
        end
        if exp_load(i,step) > 1000
            exp_load(i,step) = 1000;
        end
        if exp_load(i,step) == 0
            previous = exp_load(i,step-1);
            idx_shift = 1;
            if step < size(exp_load, 2)
                while step+idx_shift < size(exp_load, 2) && exp_load(i,step+idx_shift) == 0
                    idx_shift = idx_shift + 1;
                end
                next = exp_load(i,step+idx_shift);
                exp_load(i,step) = previous + (next - previous)/(idx_shift+1);
            end
        end
    end
end

%% Plot fixed angle and torque
figure;
set(gcf,'color','w');
title('Raw');

subplot(2,4,2);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(1,:), 'r--');
plot(exp_time, exp_position(2,:), 'b--');
% xlim([0 3]);
xlabel('Gait cycle');
ylabel('Position');
title('Joint #1 (head)');

yyaxis right;
plot(exp_time, exp_load(1,:), 'r-');
plot(exp_time, exp_load(2,:), 'b-');
ylim([-1000 1000]);
ylabel('Torque (percentage)');


subplot(2,4,3);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(3,:), 'r--');
plot(exp_time, exp_position(4,:), 'b--');
% xlim([0 3]);
title('Joint #2 (head)');

yyaxis right;
plot(exp_time, exp_load(3,:), 'r-');
plot(exp_time, exp_load(4,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,4);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(5,:), 'r--');
plot(exp_time, exp_position(6,:), 'b--');
% xlim([0 3]);
title('Joint #3');

yyaxis right;
plot(exp_time, exp_load(5,:), 'r-');
plot(exp_time, exp_load(6,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,5);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(7,:), 'r--');
plot(exp_time, exp_position(8,:), 'b--');
% xlim([0 3]);
title('Joint #4');

yyaxis right;
plot(exp_time, exp_load(7,:), 'r-');
plot(exp_time, exp_load(8,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,6);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(9,:), 'r--');
plot(exp_time, exp_position(10,:), 'b--');
% xlim([0 3]);
title('Joint #5');

yyaxis right;
plot(exp_time, exp_load(9,:), 'r-');
plot(exp_time, exp_load(10,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,7);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(11,:), 'r--');
plot(exp_time, exp_position(12,:), 'b--');
% xlim([0 3]);
title('Joint #6');

yyaxis right;
plot(exp_time, exp_load(11,:), 'r-');
plot(exp_time, exp_load(12,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');


subplot(2,4,8);
colororder({'k','k'})
set(gca,'Fontsize',16);
box on;
hold on;

yyaxis left;
plot(exp_time, exp_position(13,:), 'r--');
plot(exp_time, exp_position(14,:), 'b--');
% xlim([0 3]);
title('Joint #7 (Tail)');

yyaxis right;
plot(exp_time, exp_load(13,:), 'r-');
plot(exp_time, exp_load(14,:), 'b-');
ylim([-1000 1000]);
% ylabel('Torque (N\cdotm)');

%% Save
pos = exp_position;
load = exp_load;
time = exp_time;
path = ['fbk_clean/', name, '.mat'];
save(path, 'pos', 'load', 'time');

%% subfigure
% figure;
% set(gcf,'color','w');
% title('Raw');
% set(gca,'Fontsize',16);
% box on;
% hold on;
% 
% plot(exp_time, exp_load(1,:), 'r-');
% plot(exp_time, exp_load(2,:), 'b-');
% ylim([-1000 1000]);
% ylabel('Torque (percentage)');