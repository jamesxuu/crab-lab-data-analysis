fn=[name,'_pca.avi'];

makeMovie=1;

if makeMovie
    aviobj = VideoWriter(fn);
    aviobj.FrameRate=10;
    open(aviobj);
end

figure('Renderer', 'painters', 'Position', [0 0 1280 720]);
hold on;
set(gcf,'color','w');
subplot(2,3,4);
set(gca,'FontSize', 14);
hold on;
plot(coeff(:,1), 'linewidth', 2);
plot(coeff(:,2), 'linewidth', 2);
plot(coeff(:,3), '--');
plot(coeff(:,4), '--');
legend('PC1','PC2','PC3','PC4');
box on;
xlim([1,7]);
ylim([-1 1]);
xticks([1,2,3,4,5,6,7]);
xlabel('Joint index');

subplot(2,3,5);
set(gca,'FontSize', 14);
hold on;
p2_1 = plot(score(1,1),score(1,2),'k');
p2_2 = plot(score(1,1),score(1,2),'or');
xlabel('w_1');
ylabel('w_2');
axislim = max(abs([score(:,1);score(:,2)])) + 5;
axis equal, box on;
xlim([-axislim axislim]);
ylim([-axislim axislim]);

subplot(2,3,6);
set(gca,'FontSize', 14);
hold on;
p3_1 = plot(score(1,3),score(1,4),'k');
p3_2 = plot(score(1,3),score(1,4),'or');
xlabel('w_3');
ylabel('w_4');
axislim = max(abs([score(:,1);score(:,2)])) + 5;
axis equal, box on;
xlim([-axislim axislim]);
ylim([-axislim axislim]);

subplot(2,3,[2 3]);
set(gca,'FontSize', 14);
hold on;
p4_1 = plot(0,score(1,1), 'linewidth', 2);
p4_2 = plot(0,score(1,2), 'linewidth', 2);
p4_3 = plot(0,score(1,3), '--');
p4_4 = plot(0,score(1,4), '--');
xlabel('Time');
xlim([0 size(score, 1)-1]);
ylabel('Weight');
ylim([-axislim axislim]);
% legend('w_1','w_2','w_3','w_4');
set(gca,'xtick',[]);
box on;

pause;

for j=1:1:size(score, 1)
    set(p2_1,'XData',score(1:j,1),'YData',score(1:j,2));
    set(p2_2,'XData',score(j,1),'YData',score(j,2));
    set(p3_1,'XData',score(1:j,3),'YData',score(1:j,4));
    set(p3_2,'XData',score(j,3),'YData',score(j,4));
    set(p4_1,'XData',0:1:(j-1),'YData',score(1:j,1));
    set(p4_2,'XData',0:1:(j-1),'YData',score(1:j,2));
    set(p4_3,'XData',0:1:(j-1),'YData',score(1:j,3));
    set(p4_4,'XData',0:1:(j-1),'YData',score(1:j,4));
    
    M=getframe(gcf);
    if makeMovie
        writeVideo(aviobj,M);
    end
    
%     pause(0.001)
end

if makeMovie
    close(aviobj);
end