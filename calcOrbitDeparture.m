radii = sqrt(proj_fittedPC(1,:).^2 + proj_fittedPC(2,:).^2);
radii = radii(~isnan(radii));
radii_mean = mean(radii);
radii_std = std(radii);
ratio = radii_std/radii_mean