disp_b_stuck = [0.11	0.09	0.11	1.40	1.37	0.93	0.44;
                0.10	0.11	0.11	1.39	1.40	0.87	0.45;
                0.09	0.11	0.10	1.39	1.41	0.86	0.46;]; % in meter
            
disp_b_stuck = disp_b_stuck/0.86;
exp_disp_avg = mean(disp_b_stuck,'omitnan');
exp_disp_err = std(disp_b_stuck,'omitnan');

exp_p = 0:0.25:1.5;

figure;
set(gcf,'Position',[100 100 800 500]);
set(gcf,'color','w');
set(gca,'Fontsize',16);
hold on;
box on;
errorbar(exp_p,exp_disp_avg,exp_disp_err,'-','LineWidth',1.5,'MarkerSize',10);
ylabel('displacement before stuck (BL)');
xlabel('p');
