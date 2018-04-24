examples - overshot
_1_flingWithOvershot
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 1000
		start: 150
		min: 100 max: 200
		over: 50.

	self assert: aSplineOverScroller currentVelocity equals: 1000.0.
	self assert: aSplineOverScroller currentPosition equals: 150.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 50 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 150.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 1000.

	^ aSplineOverScroller