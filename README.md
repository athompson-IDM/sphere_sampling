# sphere_sampling

## What is this?

An illustration of the idea that a univariate normal random distribution is a one-dimensional projection of a uniform random distribution in a high-dimensional sphere.

And, that we can generalize the idea of a high-dimensional sphere to be a high-dimensional ellipsoid instead, and that the length of one of the ellipsoid's axes is connected to the variance of the associated one-dimensionally-projected univariate normal distribution.

## Huh?

These are some numerical experiments to illustrate part of Lecture 1 in Keith Ball's "An Elementary Introduction to Modern Convex Geometry."  The relevant portions are highlighted yellow in Lecture 1 in [this version of the PDF](ball.pdf).  The source version of the notes was retrieved [from here](http://library.msri.org/books/Book31/files/ball.pdf).

The code runs in Matlab. Tested in R2019b. It might work in Octave but I haven't tested that yet. If it doesn't run in Octave as-is, it probably only needs minor tweaks, because it doesn't use any fancy Matlab toolboxes or anything and it's pretty vanilla.

## Uniformly random sampling of sphere of volume 1

This is where we uniformly randomly sample a sphere of volume 1 in dimension N.  We only measure x_1 for each sample.  That is, for each sample, we record the value of the sampled point's coordinate in dimension 1. The sphere has N-1 other dimensions, and thus each random sample has N-1 other coordinates. We throw those other N-1 coordinates away. Then, we plot the distribution of values of x_1 across all the random samples we've taken.  The choice of x_1 is arbitrary; any other coordinate x_j would do for performing the measurements, and the illustration would be the same.

What you'll see is that as N gets larger, the distribution of x_1 starts to look like a normal distribution.

If you run [sphere_sampling.m](sphere_sampling.m) (Matlab script), it will generate the following figures:

1. [samples_x1.png](samples_x1.png) - Illustrates the sampling process described above, for various values of N.
2. [samples_ellipse.png](samples_ellipse.png) - Same as last item, but now in each dimension N, we use a randomly generated ellipse of volume 1 in that dimension, instead of a sphere. The ellipse is fixed for all samples in that dimension. As we vary N we are also generating a new ellipse each time, so there's really two things changing for each subplot.
3. [pairwise_distance_distributions.png](pairwise_distance_distributions.png) - Measures distribution of pairwise distances between points for each value N, for same experiments shown in #1.
4. [pairwise_distance_distributions_ellipse.png](pairwise_distance_distributions_ellipse.png) - Same as last item, but the ellipse version of the experiment described in item #2. Reminder that there's really two things changing for each subplot, both N and a new random ellipse. So some of the changes between plots have to do with N, and some are about the new random ellipse that is used for each plot.
5. [pairwise_distances_vs_N.png](pairwise_distances_vs_N.png) - Mean distance between points as a function of N, for the scenarios shown in #1.

## Uniformly random sampling of random ellipse of volume 1

Same as above, but now we squeeze/stretch/distort the sphere into an ellipse, still of volume 1.  The length of the axes are randomly generated but constrained so that the volume of the ellipse is 1.

What you'll see is that the variance of the distribution has to do with the width of the ellipse in the dimension that we are measuring, which is x_1 but could be any x_j. 

If you run [ellipse_sampling_fixed_N.m](ellipse_sampling_fixed_N.m), it will generate the following figures:

6. [sigma_vs_ellipse_cov_trials_fixed_N.png](sigma_vs_ellipse_cov_trials_fixed_N.png) - For a fixed N = 100, generates many random ellipses and does the same sampling process described above. Illustrates the sampled distribution sigma vs the (square root of) the ellipse axis length in the measured dimension.
7. [coplot_sampled_ellipse_w_normal_dist_of_equivalent_sigma.png](coplot_sampled_ellipse_w_normal_dist_of_equivalent_sigma.png) - For one of the trials in #6, co-plots the sampled ellipse distribution vs a normal distribution with the same standard deviation. If you turn on "pause mode" in [ellipse_sampling_fixed_N.m](ellipse_sampling_fixed_N.m) then you can run this trial over and over again and see how it looks for each trial.

For this script, leave pause mode disabled to generate and save #6.  It will also generate and save #7 for the last trial.  Turn pause mode on to see #7 for each trial, and press a key to continue each time.

For these experiments, the ellipse axes are aligned with the cartesian axes, and we sample on a cartesian axis. So the covariance matrix of the N-dimensional ellipse is a diagonal matrix. It would be interesting to further illustrate a situation where the ellipse is not aligned to the cartesian axes, but the sampling is still along a projection to a cartesian axis, in which case the ellipse's covariance matrix would not be a diagonal matrix. Or, equivalently, to leave the ellipse centered on the cartesian axes, and have the sampling axis not be one of the cartesian axes. For all these experiments, we're projecting to a measurement in a single dimension, so one thing to build on here would be how to illustrate a connection to projection to two or more axes, and how the covariance between the measured axes relates to the covariance matrix of the ellipse. In other words the measurement (projection) axis orientations and their relations to ellipse axis lengths and orientations.
