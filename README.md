# sphere_sampling

Some numerical experiments to illustrate part of Lecture 1 in Keith Ball's "An Elementary Introduction to Modern Convex Geometry."  The relevant portions are highlighted yellow in Lecture 1 in [this version of the PDF](ball.pdf).  The source version of the notes was retrieved (from here)[http://library.msri.org/books/Book31/files/ball.pdf]

## Random sampling of uniformly distributed sphere

This is where we sample a uniformly distributed sphere of volume 1 in dimension N.  We only measure x_1 for each sample. Then, we plot the distribution of values of x_1.

If you run (sphere_sampling.m)[sphere_sampling.m] (Matlab script), it will generate the following figures:

1. [samples_x1.png](samples_x1.png) - Illustrates the sampling process described above, for various values of N.
2. [samples_ellipse.png](samples_ellipse.png) - Same as last item, but now in each dimension N, we use a randomly generated ellipse of volume 1 in that dimension, instead of a sphere. The ellipse is fixed for all samples in that dimension.
3. [pairwise_distance_distributions.png](pairwise_distance_distributions.png) - Measures distribution of pairwise distances between points for each value N.
4. [pairwise_distance_distributions_ellipse.png](pairwise_distance_distributions_ellipse.png) - Same as last item, but the ellipse version described in item #2.
5. [pairwise_distances_vs_N.png](pairwise_distances_vs_N.png) - Mean distance between points as a function of N, for the scenarios shown in #1.
6. [sigma_vs_ellipse_cov_trials_fixed_N.png](sigma_vs_ellipse_cov_trials_fixed_N.png) - For the experiments in #2, illustrates the sampled distribution sigma vs the (square root of) the ellipse axis length in the measured dimension.

