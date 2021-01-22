num_samples = 1e5;
ruler_dimension = 1;
num_trials = 50;
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
    ellipse_sigmas(k) = std(X_ellipse(:,ruler_dimension));
    ellipse_conds(k)  = cond(ellipse_cov);
    
end


figure(1)
plot(sqrt(ellipse_as(:,ruler_dimension)),ellipse_sigmas,'bo')
xlabel('ellipse axis in measured dimension')
ylabel('ellipse-derived distribution sigma')
title(sprintf('N = %d',N))
saveas(gcf,'sigma_vs_ellipse_cov_trials_fixed_N.png')

