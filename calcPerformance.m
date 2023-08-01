% run after plotAngle_lattice.m (don't have to if load data here)

%% Load data
clear; close all;
name = 'James_75_1.0_0.8_trial_5';
path = ['tracking_clean/', name, '.mat'];
load(path);

%% Marker 1 trajectory
figure;
plot(-Xpos(:, 1));

start_idx = 107;
end_idx = 583;

%% constants
BL = 0.86; % in meters
steps_per_cycle = 145;
step_interval = 145;

starting_step = start_idx;
ending_step = end_idx;


%% Calculate displacement
step_prev = starting_step;
x_prev = mean(-Xpos(step_prev,1:9),'omitnan');
y_prev = mean(Zpos(step_prev,1:9),'omitnan');
total_disp = 0;
% cycles = 0;
step_curr = step_prev + step_interval;
while step_curr < ending_step
    x_curr = mean(-Xpos(step_curr,1:9),'omitnan');
    y_curr = mean(Zpos(step_curr,1:9),'omitnan');
    while isnan(x_curr)
        step_curr = step_curr + 1;
        x_curr = mean(-Xpos(step_curr,1:9),'omitnan');
        y_curr = mean(Zpos(step_curr,1:9),'omitnan');
    end
%     cycles = cycles + (step_curr-step_prev)/steps_per_cycle;
    d = sqrt((x_curr-x_prev)^2 + (y_curr-y_prev)^2);
%     d = sqrt((y_curr-y_prev)^2);
    total_disp = total_disp + d;
    x_prev = x_curr;
    y_prev = y_curr;
    step_prev = step_curr;
    step_curr = step_prev + step_interval;
end
x_end = mean(-Xpos(ending_step,1:9),'omitnan');
y_end = mean(Zpos(ending_step,1:9),'omitnan');
d = sqrt((x_end-x_prev)^2 + (y_end-y_prev)^2);
% d = sqrt((y_end-y_prev)^2);
total_disp = total_disp + d;
total_disp = total_disp/BL;
% cycles = cycles + (ending_step-step_prev)/steps_per_cycle;
cycles = (ending_step-starting_step)/steps_per_cycle;
vel = total_disp/cycles;
fprintf('disp = %.4f BL and %.4f meters\n', total_disp, total_disp*BL);
fprintf('velocity = %.4f BL/cycle\n', vel);

%% Calculate rotation
dist = 0;
for i = 1:9
    for j = i:9
        dist_temp = sqrt((-Xpos(starting_step, i) + Xpos(starting_step, j))^2 + (Zpos(starting_step, i) - Zpos(starting_step, j))^2);
        if dist_temp > dist
            dist = dist_temp;
            x1 = -Xpos(starting_step, j);
            y1 = Zpos(starting_step, j);
            x2 = -Xpos(starting_step, i);
            y2 = Zpos(starting_step, i);
            vec1 = [x1-x2; y1-y2];
        end
    end
end

dist = 0;
for i = 1:9
    for j = i:9
        dist_temp = sqrt((-Xpos(ending_step, i) + Xpos(ending_step, j))^2 + (Zpos(ending_step, i) - Zpos(ending_step, j))^2);
        if dist_temp > dist
            dist = dist_temp;
            x3 = -Xpos(ending_step, j);
            y3 = Zpos(ending_step, j);
            x4 = -Xpos(ending_step, i);
            y4 = Zpos(ending_step, i);
            vec2 = [x3-x4; y3-y4];
        end
    end
end

figure;
hold on;
quiver(x1,y1,x2-x1,y2-y1);
quiver(x3,y3,x4-x3,y4-y3);
axis equal;

rotation = acos(dot(vec1, vec2)/(norm(vec1)*norm(vec2)))/pi*180;
fprintf('rotation = %.4f degree\n', rotation);