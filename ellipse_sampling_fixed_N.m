% Set this to 0 if you just want to generate figure 2, and you'll also
% get the last trial in figure 1.
%
% Leave it 1 to step one trial at a time through co-plotting 
% the sampled ellipse with the normal distribution of equivalent
% sigma.
pause_mode = 0

num_samples = 1e5;
ruler_dimension = 1;
num_trials = 5;
n_dist_bins=100;
N = 100;
% radius of ball of volume 1.
R = ( gamma(0.5*N+1) / ( pi^(N/2) ) ) ^ (1/N);

ellipse_sigmas = zeros(1,length(num_trials))
ellipse_conds  = zeros(1,length(num_trials))
ellipse_as     = zeros(num_trials, N);

for k = 1:num_trials
    % sample uniformly from random ellipsoid of dimension N
    % First calculate ellipse axis lengths.
    % It will be aligned with the cartesian axes.
    % Just need a1 * a2 * ... * aN = R, where R is the equivalent
    % radius of a volume one sphere in dimension N.    
    ellipse_a = zeros(1,N);
    % So we'll chop R up into the pieces a_i.
    R_remaining = R;
    for i = 1:N
        if i == N
           ellipse_a(i) = R_remaining; 
        else
            % Take a random fraction of remaining R, bounded,
            % but maybe we don't actually need to bound it.
            ellipse_a(i) = rand(1) * (R_remaining*0.95);
            R_remaining = R_remaining / ellipse_a(i);
        end
    end
    % just to print it
    ellipse_a = ellipse_a
    R
    ellipse_as(k,:) = ellipse_a;
    prod_ellipse_a = prod(ellipse_a)
    ellipse_cov = diag(ellipse_a);    
    X_ellipse = draw_from_ellipsoid(ellipse_cov, zeros(1,N), num_samples); 
    [y_ellipse,bin_ellipse] = hist(X_ellipse(:,ruler_dimension),n_dist_bins);
    bin_width = bin_ellipse(2) - bin_ellipse(1)
    figure(1)
    hold off
    
    % Something isn't quite right with this normalization, but
    % the same thing is wrong with the normalization of the coplotted
    % function below so it's ok for now.
    
    y_ellipse_normalized = y_ellipse / (num_samples*bin_width)    
    plot(bin_ellipse,y_ellipse_normalized, 'o')
    ellipse_sigmas(k) = std(X_ellipse(:,ruler_dimension));
    ellipse_conds(k)  = cond(ellipse_cov);
    
    % normal dist w/ equiv sigma
    nd = ellipse_sigmas(k) * randn(num_samples,1);
    [y_nd,bin_nd] = hist(nd,n_dist_bins);
    bin_width = bin_nd(2) - bin_nd(1)    
    
    % This normalization has the same problem as the other one described
    % above, but they are wrong in the same way so it's ok for now.
    y_nd_normalized = y_nd / (num_samples*bin_width);
    hold on
    plot(bin_nd, y_nd_normalized, '-')
    axis([-1,1,0,10])
    legend('sampled ellipse','normal dist w/ same sigma')
    title(sprintf('Distribution of x_%d in uniformly sampled random ellipse of volume 1, N=%d',ruler_dimension,N),'fontsize',8)
        
    if pause_mode == 1
        pause
    end
end


figure(2)
plot(sqrt(ellipse_as(:,ruler_dimension)),ellipse_sigmas,'bo')
xlabel('sqrt ellipse axis in measured dimension')
ylabel('ellipse-derived distribution sigma')
title(sprintf('N = %d',N))
saveas(gcf,'sigma_vs_ellipse_cov_trials_fixed_N.png')

