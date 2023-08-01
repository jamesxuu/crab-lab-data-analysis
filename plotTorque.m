%% Load data
% clear; close all;

if_all_positive_torque = 0;

name = '75_1.0_ctrl2_passiveness1.25_3';
path = ['fbk_clean/', name, '.mat'];
exp = load(path);
% exp_load = exp_fbk.fbk.dxl_present_load;
exp_load = exp.load/1000*1.4;
exp_position = exp.pos;
exp_time = exp.time;

ending_idx = length(exp_load);

exp_load = exp_load(:, 1:ending_idx);
exp_position = exp_position(:, 1:ending_idx);
exp_time = exp_time(1:ending_idx);

%% Load calibration data
% name = ['calibrate_', name];
name = '75_1.0_ctrl2_passiveness1.25_calib';
path = ['fbk_clean/', name, '.mat'];
calib = load(path);
calib_load = calib.load/1000*1.4;
calib_time = calib.time;

while length(calib_load) < ending_idx
    calib_load = [calib_load, calib_load];
    calib_time = [calib_time, calib_time + calib_time(end)];
end

calib_load = calib_load(:, 1:ending_idx);
calib_time = calib_time(1:ending_idx);

%% External torque / tension
external_load = exp_load - calib_load;

% external_load = exp_load;
% external_load(1:8,:) = exp_load(1:8,:) - calib_load(1:8,:);
% external_load(9:14,:) = exp_load(9:14,:);

tension = external_load/0.010;

%% non-negative torque
if if_all_positive_torque
    for i = 1:size(external_load,1)
        for j = 1:size(external_load,2)
            if external_load(i,j) < 0
                external_load(i,j) = 0;
            end
        end
    end
end

%% Angular Impulse
diff_exp_time = exp_time - [0, exp_time(1:end-1)];
external_impulse = zeros(size(external_load));
external_cumsum_impulse = zeros(size(external_load));
for i = 1:14
    external_impulse(i,:) = external_load(i,:) .* diff_exp_time;
    external_cumsum_impulse(i,:) = cumsum(external_impulse(i,:));
end
external_total_impulse = sum(external_cumsum_impulse, 1);

%% Energy
diff_exp_position = [zeros(14,1), exp_position(:, 2:end) - exp_position(:, 1:end-1)];
diff_exp_position = diff_exp_position/4096*(2*pi);
external_energy = zeros(size(external_load));
external_cumsum_energy = zeros(size(external_load));
for i = 1:14
    external_energy(i,:) = abs(external_load(i,:)) .* abs(diff_exp_position(i,:));
%     external_energy(i,:) = external_load(i,:) .* diff_exp_position(i,:);
    external_cumsum_energy(i,:) = cumsum(external_energy(i,:));
end
external_total_energy = sum(external_cumsum_energy, 1);
fprintf('%.4f J per cycle\n', external_total_energy(end)/(ending_idx/250));
fprintf('%.4f J in total\n', external_total_energy(end));

% %% Plot raw load
% figure;
% set(gcf,'color','w');
% title('Raw Torque');
% 
% subplot(2,4,2);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #1 (head)');
% plot(exp_load(1,:), 'r-');
% plot(exp_load(2,:), 'b-');
% ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');
% xlabel('Time (s)');
% 
% 
% subplot(2,4,3);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #2');
% plot(exp_load(3,:), 'r-');
% plot(exp_load(4,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,4);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #3');
% plot(exp_load(5,:), 'r-');
% plot(exp_load(6,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,5);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #4');
% plot(exp_load(7,:), 'r-');
% plot(exp_load(8,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,6);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #5');
% plot(exp_load(9,:), 'r-');
% plot(exp_load(10,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,7);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #6');
% plot(exp_load(11,:), 'r-');
% plot(exp_load(12,:), 'b-');
% ylim([-0.5 0.8]);
% 
% subplot(2,4,8);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #7');
% plot(exp_load(13,:), 'r-');
% plot(exp_load(14,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% %% Plot calibration load
% figure;
% set(gcf,'color','w');
% title('Calibration Torque');
% 
% subplot(2,4,2);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #1 (head)');
% plot(calib_load(1,:), 'r-');
% plot(calib_load(2,:), 'b-');
% ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');
% xlabel('Time (s)');
% 
% 
% subplot(2,4,3);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #2');
% plot(calib_load(3,:), 'r-');
% plot(calib_load(4,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,4);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #3');
% plot(calib_load(5,:), 'r-');
% plot(calib_load(6,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,5);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #4');
% plot(calib_load(7,:), 'r-');
% plot(calib_load(8,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,6);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #5');
% plot(calib_load(9,:), 'r-');
% plot(calib_load(10,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,7);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #6');
% plot(calib_load(11,:), 'r-');
% plot(calib_load(12,:), 'b-');
% ylim([-0.5 0.8]);
% 
% subplot(2,4,8);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #7');
% plot(calib_load(13,:), 'r-');
% plot(calib_load(14,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% %% Plot external load / tension
% figure;
% set(gcf,'color','w');
% title('Calibration Torque');
% 
% subplot(2,4,2);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #1 (head)');
% plot(external_load(1,:), 'r-');
% plot(external_load(2,:), 'b-');
% ylim([-0.5 0.8]);
% ylabel('Torque (N\cdotm)');
% xlabel('Time (s)');
% 
% 
% subplot(2,4,3);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #2');
% plot(external_load(3,:), 'r-');
% plot(external_load(4,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,4);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #3');
% plot(external_load(5,:), 'r-');
% plot(external_load(6,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,5);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #4');
% plot(external_load(7,:), 'r-');
% plot(external_load(8,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,6);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #5');
% plot(external_load(9,:), 'r-');
% plot(external_load(10,:), 'b-');
% ylim([-0.5 0.8]);
% 
% 
% subplot(2,4,7);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #6');
% plot(external_load(11,:), 'r-');
% plot(external_load(12,:), 'b-');
% ylim([-0.5 0.8]);
% 
% subplot(2,4,8);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #7');
% plot(external_load(13,:), 'r-');
% plot(external_load(14,:), 'b-');
% ylim([-0.5 0.8]);
% 
% %% Plot external angular implulse
% figure;
% set(gcf,'color','w');
% title('External accumulative angular implulse');
% 
% subplot(2,4,1);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Total impulse');
% plot(external_total_impulse, 'r-');
% % ylim([-0.5 5]);
% ylabel('Angular Impulse (N\cdotm\cdots)');
% xlabel('Time (s)');
% 
% subplot(2,4,2);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #1 (head)');
% plot(external_cumsum_impulse(1,:), 'r-');
% plot(external_cumsum_impulse(2,:), 'b-');
% ylim([-0.5 5]);
% xlabel('Time (s)');
% 
% 
% subplot(2,4,3);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #2');
% plot(external_cumsum_impulse(3,:), 'r-');
% plot(external_cumsum_impulse(4,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,4);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #3');
% plot(external_cumsum_impulse(5,:), 'r-');
% plot(external_cumsum_impulse(6,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,5);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #4');
% plot(external_cumsum_impulse(7,:), 'r-');
% plot(external_cumsum_impulse(8,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,6);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #5');
% plot(external_cumsum_impulse(9,:), 'r-');
% plot(external_cumsum_impulse(10,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,7);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #6');
% plot(external_cumsum_impulse(11,:), 'r-');
% plot(external_cumsum_impulse(12,:), 'b-');
% ylim([-0.5 5]);
% 
% subplot(2,4,8);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #7');
% plot(external_cumsum_impulse(13,:), 'r-');
% plot(external_cumsum_impulse(14,:), 'b-');
% ylim([-0.5 5]);
% 
% %% Plot external energy
% figure;
% set(gcf,'color','w');
% title('External accumulative angular implulse');
% 
% subplot(2,4,1);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Total energy');
% plot(external_total_energy, 'r-');
% % ylim([-0.5 5]);
% ylabel('Energy (J)');
% xlabel('Time (s)');
% 
% subplot(2,4,2);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #1 (head)');
% plot(external_cumsum_energy(1,:), 'r-');
% plot(external_cumsum_energy(2,:), 'b-');
% ylim([-0.5 5]);
% xlabel('Time (s)');
% 
% 
% subplot(2,4,3);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #2');
% plot(external_cumsum_energy(3,:), 'r-');
% plot(external_cumsum_energy(4,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,4);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #3');
% plot(external_cumsum_energy(5,:), 'r-');
% plot(external_cumsum_energy(6,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,5);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #4');
% plot(external_cumsum_energy(7,:), 'r-');
% plot(external_cumsum_energy(8,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,6);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #5');
% plot(external_cumsum_energy(9,:), 'r-');
% plot(external_cumsum_energy(10,:), 'b-');
% ylim([-0.5 5]);
% 
% 
% subplot(2,4,7);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #6');
% plot(external_cumsum_energy(11,:), 'r-');
% plot(external_cumsum_energy(12,:), 'b-');
% ylim([-0.5 5]);
% 
% subplot(2,4,8);
% colororder({'k','k'})
% set(gca,'Fontsize',16);
% box on;
% hold on;
% title('Joint #7');
% plot(external_cumsum_energy(13,:), 'r-');
% plot(external_cumsum_energy(14,:), 'b-');
% ylim([-0.5 5]);