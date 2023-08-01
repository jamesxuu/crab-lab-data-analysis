%% Load data
% clear; close all;
name = 'James_75_1.0_0.8_trial_2.mat';
path = ['tracking_clean/', name];
load(path);

%% Switch order
marker_1 = 4;
marker_2 = 5;
idx_start = 145;
idx_end = 602;
temp_x = Xpos(idx_start:idx_end,marker_1);
temp_y = Ypos(idx_start:idx_end,marker_1);
temp_z = Zpos(idx_start:idx_end,marker_1);
Xpos(idx_start:idx_end,marker_1) = Xpos(idx_start:idx_end,marker_2);
Ypos(idx_start:idx_end,marker_1) = Ypos(idx_start:idx_end,marker_2);
Zpos(idx_start:idx_end,marker_1) = Zpos(idx_start:idx_end,marker_2);
Xpos(idx_start:idx_end,marker_2) = temp_x;
Ypos(idx_start:idx_end,marker_2) = temp_y;
Zpos(idx_start:idx_end,marker_2) = temp_z;

%% Visualize
figure;
title('after correction');
% hold on;
subplot(1,2,1);
hold on;
for i = 1:9
    plot(Xpos(:, i));
end
legend;
subplot(1,2,2);
hold on;
for i = 1:9
    plot(Zpos(:, i));
end
legend('location','southeast');

figure;
title('body shape');
plot(-Xpos(2,1:9), Zpos(2,1:9));
axis equal

%% Save
path = ['tracking_clean/', name];
save(path, 'Xpos', 'Ypos', 'Zpos', 't');
