%% Load data
clear; close all;
name = '75_1.0_ctrl2_passiveness0.75_1';
path = ['tracking_clean/', name, '.mat'];
load(path);


%% Find starting ending time
time_joint_angle = t;
joint_angle = zeros(length(t), 7);
for step = 1:length(t)
    for joint_idx = 1:7
        joint_angle(step, joint_idx) = calcSingleAngle(Xpos(step, joint_idx:joint_idx+2), Zpos(step, joint_idx:joint_idx+2));
    end
end
joint_angle = joint_angle/pi*180;

figure;
plot(Xpos(:,1))

%% Find starting ending time
start_idx = 32;
end_idx = 459;
joint_angle = joint_angle(start_idx:end_idx, :);
time_joint_angle = time_joint_angle(start_idx:end_idx) - time_joint_angle(start_idx);
Xpos = Xpos(start_idx:end_idx,:);
Ypos = Ypos(start_idx:end_idx,:);
Zpos = Zpos(start_idx:end_idx,:);

%% Projecting PCA
f = 1.00;
basis1 = cos(2*pi*f*(1:7)/(7) + pi);
basis2 = -sin(2*pi*f*(1:7)/(7) + pi);
% basis1 = sin(2*pi*f*(1:7)/(7) - 75/180*pi);
% basis2 = cos(2*pi*f*(1:7)/(7) - 75/180*pi);
fitted_PC = [basis1' basis2'];
B = inv(fitted_PC'*fitted_PC)*fitted_PC'; % coe matrix to find the least square
proj_fittedPC = B*joint_angle.';
diff_joint_angle = joint_angle.'-fitted_PC*proj_fittedPC;
diff_joint_angle = diff_joint_angle(~isnan(diff_joint_angle));
col = floor(size(diff_joint_angle,1)/7);
diff_joint_angle = reshape(diff_joint_angle, [7 col]);
r = norm(diff_joint_angle,2)/norm(joint_angle.',2); % R^2 = 1-r^2
fprintf('R^2 = %4f \n', 1-r^2);
[~,~,~,~,explained,~] = pca(proj_fittedPC');
fprintf('eccentricity = %4f \n', 1-explained(2)/explained(1));


figure;
set(gca,'FontSize', 14);
hold on;
plot(proj_fittedPC(1,:),proj_fittedPC(2,:),'k');
xlabel('w_1');
ylabel('w_2');
axis equal, box on;
xlim([-80 80]);
ylim([-80 80]);

%% Plot robot traj
xs = -Xpos(:,1:9);
ys = Zpos(:,1:9);
colormap = [linspace(0, 214/255, length(xs))', linspace(52/255, 216/255, length(xs))', linspace(80/255, 233/255, length(xs))'];
figure;
set(gcf,'color','w');
set(gca,'FontSize', 14);
hold on;
axis equal;
box on;
% lower_bound = min(min(Zpos)) - 0.1;
% upper_bound = max(max(Zpos)) + 0.1;
xlabel('x (m)');
ylabel('y (m)');
for step = 1:21:length(xs)
%     plot(xs{step}(1),ys{step}(1),'o','color',colormap(step,:));
    plot(xs(step,1:9),ys(step,1:9),'color',colormap(step,:));
end
% cbh = colorbar;
% cbh.Ticks = linspace(0, 1, 4);
% cbh.TickLabels = {'0','1','2','3'};
% ylabel(cbh, 'Gait cycle', 'Fontsize',16)
% cbh.Ticks = linspace(0, 1, 2);
% cbh.TickLabels = {'0', sprintf('t = %.1f s', t(end))};
% ylabel(cbh, 'Time (s)', 'Fontsize',16)
% saveas(gcf,sprintf('results/%s.png', name));
% ylim([-50 350]);