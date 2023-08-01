% Use after plotAngle.m

%% input PC and weights
basis1 = cos(2*pi*0.8*(1:7)/(7));
basis2 = -sin(2*pi*0.8*(1:7)/(7));
% basis1 = cos(2*pi*1.0*(0:6)/(6));
% basis2 = -sin(2*pi*1.0*(0:6)/(6));
A = 45;
w1 = A*sin(0:0.01:2*pi);
w2 = A*cos(0:0.01:2*pi);
figure;
set(gcf,'Position',[100 100 1100 500]);
set(gcf,'color','w');
subplot(1,2,1);
set(gca,'FontSize', 14);
hold on;
box on;
xlim([1,7]);
xticks([1,2,3,4,5,6,7]);
xlabel('Joint index')
plot(basis1);
plot(basis2);
title('Shape basis')
subplot(1,2,2);
set(gca,'FontSize', 14);
hold on;
axis equal;
box on;
plot(w1,w2);
xlabel('w_1');
ylabel('w_2');
xlim([-A A]);
ylim([-A A]);
title('Gait path in shape space')

%% PCA
joint_angle = rmmissing(joint_angle);
[coeff, score] = pca(joint_angle);
[U,S,V] = svd(joint_angle,'econ');

figure;
set(gcf,'Position',[100 100 1100 500]);
set(gcf,'color','w');
subplot(1,2,1);
set(gca,'FontSize', 14);
hold on;
title('sigular values');
semilogy(diag(S), 'k-o', 'LineWidth', 2);
xticks([1,2,3,4,5,6,7]);
axis tight, grid on, box on;
subplot(1,2,2);
set(gca,'FontSize', 14);
hold on;
title('cumsum(s)/sum(s)');
plot(cumsum(diag(S))./sum(diag(S)),'k-o','LineWidth',2);
xticks([1,2,3,4,5,6,7]);
axis tight, grid on, box on;

%% Plot PCs and weights
figure;
set(gcf,'Position',[100 100 1100 500]);
set(gcf,'color','w');
subplot(1,2,1);
set(gca,'FontSize', 14);
hold on;
plot(coeff(:,1));
plot(coeff(:,2));
legend('PC1','PC2');
box on;
xlim([1,7]);
xticks([1,2,3,4,5,6,7]);
xlabel('Joint index');

subplot(1,2,2);
set(gca,'FontSize', 14);
hold on;
plot(score(:,1),score(:,2),'k');
xlabel('w_1');
ylabel('w_2');
axislim = max(abs([score(:,1);score(:,2)])) + 5;
axis equal, box on;
xlim([-axislim axislim]);
ylim([-axislim axislim]);

% subplot(1,3,3);
% set(gca,'FontSize', 14);
% hold on;
% plot(score(:,1));
% plot(score(:,2));
% plot(score(:,3));
% plot(score(:,4));
% xlabel('Time');
% ylabel('Weight');
% legend('w_1','w_2','w_3','w_4');
% set(gca,'xtick',[]);
% box on;

%% Normalized PCs and weights
coeff_1 = coeff(:,1)/max(coeff(:,1));
coeff_2 = coeff(:,2)/max(coeff(:,2));
score_1 = score(:,1)*max(coeff(:,1));
score_2 = score(:,2)*max(coeff(:,2));

figure;
set(gcf,'Position',[100 100 1100 500]);
set(gcf,'color','w');
subplot(1,2,1);
set(gca,'FontSize', 14);
hold on;
plot(coeff_1);
plot(coeff_2);
legend('PC1','PC2');
box on;
xlim([1,7]);
xticks([1,2,3,4,5,6,7]);
xlabel('Joint index');

subplot(1,2,2);
set(gca,'FontSize', 14);
hold on;
plot(score_1,score_2,'k');
xlabel('w_1');
ylabel('w_2');
axislim = max(abs([score_1;score_2])) + 5;
axis equal, box on;
xlim([-axislim axislim]);
ylim([-axislim axislim]);