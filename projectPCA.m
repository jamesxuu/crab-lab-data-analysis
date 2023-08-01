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
axislim = max(abs([proj_fittedPC(1,:),proj_fittedPC(2,:)])) + 5;
axis equal, box on;
xlim([-axislim axislim]);
ylim([-axislim axislim]);

% phase = atan2(proj_fittedPC(2,:),proj_fittedPC(1,:));
% phase = unwrap(phase);
% phase = -phase;
% figure;
% set(gca,'FontSize', 14);
% hold on;
% plot(30:50,phase(30:50),'k');