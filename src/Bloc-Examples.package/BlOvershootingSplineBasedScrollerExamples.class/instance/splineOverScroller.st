examples - instance creation
splineOverScroller
	<gtExample>
	| aSplineOverScroller |
	
	aSplineOverScroller := BlOvershootingSplineBasedScroller new.
	
	self assert: aSplineOverScroller currentPosition equals: 0.0.
	self assert: aSplineOverScroller currentVelocity equals: 0.0.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	
	self assert: aSplineOverScroller splineDistance equals: 0.0.
	self assert: aSplineOverScroller splineDuration isZero.
	
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	
	self assert: aSplineOverScroller ppi equals: 96.0.

	^ aSplineOverScroller