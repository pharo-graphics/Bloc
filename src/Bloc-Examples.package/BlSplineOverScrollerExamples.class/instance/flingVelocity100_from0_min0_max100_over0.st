examples - fling
flingVelocity100_from0_min0_max100_over0
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 100
		start: 0
		min: 0 max: 100
		over: 0.

	self assert: aSplineOverScroller currentVelocity equals: 100.0.
	self assert: aSplineOverScroller currentPosition equals: 0.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 148 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 5.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 0.
	self assert: aSplineOverScroller splineDistance equals: 5.
	self assert: aSplineOverScroller splineDuration equals: 148 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 0.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 100.

	^ aSplineOverScroller