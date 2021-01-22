# sphere_sampling

Some numerical experiments to illustrate part of Lecture 1 in Keith Ball's "An Elementary Introduction to Modern Convex Geometry."  The relevant portions are highlighted yellow in Lecture 1 in [this version of the PDF](ball.pdf).  The source version of the notes was retrieved (from here)[http://library.msri.org/books/Book31/files/ball.pdf]

## Random sampling of uniformly distributed sphere of volume 1

This is where we sample a uniformly distributed sphere of volume 1 in dimension N.  We only measure x_1 for each sample. Then, we plot the distribution of values of x_1.

If you run (sphere_sampling.m)[sphere_sampling.m] (Matlab script), it will generate the following figures:

1. [samples_x1.png](samples_x1.png) - Illustrates the sampling process described above, for various values of N.
2. [samples_ellipse.png](samples_ellipse.png) - Same as last item, but now in each dimension N, we use a randomly generated ellipse of volume 1 in that dimension, instead of a sphere. The ellipse is fixed for all samples in that dimension. As we vary N we are also generating a new ellipse each time, so there's really two things changing for each subplot.
3. [pairwise_distance_distributions.png](pairwise_distance_distributions.png) - Measures distribution of pairwise distances between points for each value N.
4. [pairwise_distance_distributions_ellipse.png](pairwise_distance_distributions_ellipse.png) - Same as last item, but the ellipse version described in item #2.
5. [pairwise_distances_vs_N.png](pairwise_distances_vs_N.png) - Mean distance between points as a function of N, for the scenarios shown in #1.

## Random sampling of uniformly distributed random ellipse of volume 1

Same as above, but now we squeeze the sphere into an ellipse, still of volume 1.  The length of the axes are randomly generated but constrained so that the volume of the ellipse is 1.

If you run [ellipse_sampling_fixed_N.m](ellipse_sampling_fixed_N.m), it will generate the following figures:

6. [sigma_vs_ellipse_cov_trials_fixed_N.png](sigma_vs_ellipse_cov_trials_fixed_N.png) - For a fixed N = 100, generates many random ellipses and does the same sampling process described above. Illustrates the sampled distribution sigma vs the (square root of) the ellipse axis length in the measured dimension.
7. [coplot_sampled_ellipse_w_normal_dist_of_equivalent_sigma.png](coplot_sampled_ellipse_w_normal_dist_of_equivalent_sigma.png) - For one of the trials in #6, co-plots the sampled ellipse distribution vs a normal distribution with the same standard deviation. If you turn on "pause mode" in [ellipse_sampling_fixed_N.m](ellipse_sampling_fixed_N.m) then you can run this trial over and over again and see how it looks for each trial.

For this script, leave pause mode disabled to generate and save #6.  It will also generate and save #7 for the last trial.  Turn pause mode on to see #7 for each trial, and press a key to continue each time.
