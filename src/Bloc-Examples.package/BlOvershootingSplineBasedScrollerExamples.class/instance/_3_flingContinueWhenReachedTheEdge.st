examples - overshot
_3_flingContinueWhenReachedTheEdge
	<gtExample>
	| aSplineOverScroller shouldContinue |

	aSplineOverScroller := self _2_flingMovingToTheEdge.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	"we should spring back, because velocity is very high and we overshot"
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 902.15955).
	self assert: aSplineOverScroller currentPosition equals: 205. "<- since we overshot position is greater than 200"
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: (aSplineOverScroller deceleration closeTo: -8968.09).
	self assert: aSplineOverScroller duration equals: 105 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 250.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 200. "<- we start springing back from our previous 'final' position"
	self assert: aSplineOverScroller startTime equals: self exampleDate + 50 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: 947.

	^ aSplineOverScroller