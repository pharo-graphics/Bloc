I encapsulate animated smooth scrolling in both X and Y directions with the ability to overshoot the bounds of a scrolling operation.
For each axis I contain a separate spline based overshooting scroller (BlSplineBasedOvershootingScroller).

! Scrolling modes

There are two types of smooth scroll modes: fling and smooth scroll. 

!! Fling

The goal of Fling is to simulate physics and gravity so that it could be used for finger-based scrolling. Fling's behaviour is implemented based on spline approximation and supports overshooting distance. 

!! Smooth scroll

Is a simple smooth animated scroll without support of the overshooting and that relies on an interpolator to compute scroll delta