
num_samples = 1e6;
n_dist_bins = 100;
ruler_dimension = 1;

num_sample_distances = 1e5;
n_pairwise_distance_distribution_bins = 1000;

subplot_indices = reshape(1:20, 4, 5).';
subplot_index = 1;
NN=[2,3,4,5,6,7,8,9,10,11,20,40,60,80,100,150,200,250,300,340]

zz = zeros(1,length(NN))

ellipse_sigmas = zeros(1,length(NN))
ellipse_conds  = zeros(1,length(NN))

for k = 1:length(NN)
    % Sample points uniformly distributed in sphere of volume 1.
    
    N = NN(k)
    % volume of ball of radius 1 (see Keith Ball).
    V1 = ( pi^(N/2) ) / (gamma(0.5*N+1));
    % radius of ball of volume 1 (again Ball).
    R = ( gamma(0.5*N+1) / ( pi^(N/2) ) ) ^ (1/N);
    X = randsphere(num_samples, N, R);
    [y,bin] = hist(X(:,ruler_dimension),n_dist_bins);
    
    sumy = sum(y)
    
    y_normalized = y / sum(y);
      
    figure(1)
    set(gcf,'Position',[1,1,1500,800])
    sgtitle('Distribution of x_1 in uniformly sampled sphere of volume 1 in dimension N', 'FontSize', 8)
    subplot(5,4,subplot_indices(subplot_index))
    stem(bin,y_normalized)
    title(N)
    axis([-1,1,0,0.045])

    %figure(3)
    %sgtitle('Distribution of x_1 in uniformly sampled sphere of dimension N (zoomed in)', 'FontSize', 8)
    %subplot(5,4,subplot_indices(subplot_index))
    %stem(bin,y)
    %title(N)
    % zoomed in to look at the shoulders.
    %axis([-0.6,0.6,0,1300])
    
    % Distances between randomly selected pairs of points.
    P1_k = randi(num_samples,1,num_sample_distances);
    P2_k = randi(num_samples,1,num_sample_distances);
    P1 = X(P1_k,:);
    P2 = X(P2_k,:);
    D = vecnorm(P1-P2, 2, 2);
    
    [pairwise_distance_count, pairwise_distance_bins] = hist(D, n_pairwise_distance_distribution_bins );
    figure(2)
    set(gcf,'Position',[1,1,1500,800])
    sgtitle(sprintf('Pairwise distance between %d randomly sampled pairs of uniformly distributed points in sphere of volume 1 in dimension N', num_sample_distances), 'FontSize', 8)
    subplot(5,4,subplot_indices(subplot_index))
    stem(pairwise_distance_bins, pairwise_distance_count./sum(pairwise_distance_count))
    title(N)
    axis([0,8,0,0.006])
    
    [m,i] = max(pairwise_distance_count);
    zz(k) = pairwise_distance_bins(i);    
    
    
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
    prod_ellipse_a = prod(ellipse_a)
    ellipse_cov = diag(ellipse_a);
    X_ellipse = draw_from_ellipsoid(ellipse_cov, zeros(1,N), num_samples);        
    [y_ellipse,bin_ellipse] = hist(X_ellipse(:,ruler_dimension),n_dist_bins);
    y_ellipse_normalized = y_ellipse / sum(y_ellipse);
    ellipse_sigmas(k) = std(X_ellipse(:,ruler_dimension));
    ellipse_conds(k)  = cond(ellipse_cov);
    
    figure(3)
    set(gcf,'Position',[1,1,1500,800])
    sgtitle('Distribution of x_1 in uniformly sampled random ellipsoid of volume 1 in dimension N', 'FontSize', 8)
    subplot(5,4,subplot_indices(subplot_index))
    stem(bin_ellipse,y_ellipse_normalized)
    title(N)
    axis([-1,1,0,0.045])
    
    
    % Distances between randomly selected pairs of points.
    P1_k = randi(num_samples,1,num_sample_distances);
    P2_k = randi(num_samples,1,num_sample_distances);
    P1 = X_ellipse(P1_k,:);
    P2 = X_ellipse(P2_k,:);
    D = vecnorm(P1-P2, 2, 2);
    [pairwise_distance_count, pairwise_distance_bins] = hist(D, n_pairwise_distance_distribution_bins );
    
    figure(4)
    set(gcf,'Position',[1,1,1500,800])
    sgtitle(sprintf('Pairwise distance between %d randomly sampled pairs of uniformly distributed points in random ellipse of volume 1 in dimension N', num_sample_distances), 'FontSize', 8)
    subplot(5,4,subplot_indices(subplot_index))
    stem(pairwise_distance_bins, pairwise_distance_count./sum(pairwise_distance_count))
    title(N)
    axis([0,8,0,0.006])
    
    
    subplot_index = subplot_index + 1;
end

figure(5)    
hold off
plot(sqrt(NN),zz,'bo')
xlabel('$\sqrt{N}$','Interpreter','latex')
ylabel('$\hat{d}$','Interpreter','latex')

p = polyfit(sqrt(NN),zz,1)
zfit = polyval(p,sqrt(NN));
hold on
plot(sqrt(NN),zfit,'k-')
hold off
% Place equation in upper left of graph.
xl = xlim;
yl = ylim;
xt = 0.05 * (xl(2)-xl(1)) + xl(1);
yt = 0.90 * (yl(2)-yl(1)) + yl(1);
caption = sprintf('y = %f * x + %f', p(1), p(2));
text(xt, yt, caption, 'FontSize', 10, 'Color', 'k', 'FontWeight', 'bold');

saveas(gcf,'pairwise_distances_vs_N.png')

figure(1)
saveas(gcf,'samples_x1.png')
figure(2)
saveas(gcf,'pairwise_distance_distributions.png')
figure(3)
saveas(gcf,'samples_ellipse.png')
figure(4)
saveas(gcf,'pairwise_distance_distributions_ellipse.png')

