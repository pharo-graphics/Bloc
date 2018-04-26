examples - overshot
_5_flingContinueWhenReachedTheOvershotMax
	<gtExample>
	| aSplineOverScroller shouldContinue |

	aSplineOverScroller := self _4_flingMovingToTheOvershotMax.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 6.5756397).
	self assert: aSplineOverScroller currentPosition equals: 250.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self assert: aSplineOverScroller startTime equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller