%% Load data
clear; close all;
name = '65_1.0_ctrl1_1';
path = ['tracking_clean/', name, '.mat'];
load(path);

%% Plot robot config
% figure;
% hold on;
% axis equal;
% lower_bound = min(min(Zpos)) - 0.2;
% upper_bound = max(max(Zpos)) + 0.2;
% ylim([lower_bound, upper_bound]);
% xlim([0 upper_bound-lower_bound]);
% step_init = 10;
% % util_plotConfig;
% robot_plot = plot(-Xpos(step_init,1:9),Zpos(step_init,1:9));
% % axis equal;
% pause;
% 
% for step = step_init:size(Xpos,1)
% %     clf;
%     tic;
% %     util_plotConfig;
%     set(robot_plot, 'xData', -Xpos(step,1:9), 'yData', Zpos(step,1:9))
%     time = toc;
%     if step < size(Xpos,1)
% %         pause(max(0, t(step+1)-t(step)-time));
%         pause(0.001);
%     end
% end

%% Find starting ending time
starting_step = 39;
ending_step = 645;

Xpos = Xpos(starting_step:ending_step, 1:9);
Zpos = Zpos(starting_step:ending_step, 1:9);

%% Plot robot traj
addpath('crameri');
colormap_roma = flipud(crameri('roma',size(Xpos,1)));
figure;
set(gcf,'color','w');
set(gca,'FontSize', 14);
hold on;
axis equal;
box on;
% lower_bound = min(min(Zpos)) - 0.1;
% upper_bound = max(max(Zpos)) + 0.1;
% lower_bound = - 0.1;
% upper_bound = 2.1;
% xlim([-lower_bound, -upper_bound]);
% ylim([mean(-Xpos(10,1:9))-(upper_bound-lower_bound)/2 mean(-Xpos(10,1:9))+(upper_bound-lower_bound)/2]);
xlabel('x (m)');
ylabel('y (m)');
for step = 1:1:size(Xpos,1)
    plot(mean(-Zpos(step,1:9)),mean(-Xpos(step,1:9)),'.','MarkerSize',15,'color',colormap_roma(step,:));
end
colormap(colormap_roma);
cbh = colorbar;
% cbh.Ticks = linspace(0, 1, 4);
% cbh.TickLabels = {'0','1','2','3'};
% ylabel(cbh, 'Gait cycle', 'Fontsize',16)
cbh.Ticks = linspace(0, 1, 2);
cbh.TickLabels = {'0', sprintf('t = %.1f s', t(end))};
ylabel(cbh, 'Time (s)', 'Fontsize',16)
% saveas(gcf,sprintf('results/%s.png', name));