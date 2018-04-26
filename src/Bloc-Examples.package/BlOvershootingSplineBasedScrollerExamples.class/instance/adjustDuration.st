examples - physics
adjustDuration
	<gtExample>
	| aSplineOverScroller aDjustedDuration |

	aSplineOverScroller := self splineOverScroller.

	aDjustedDuration := aSplineOverScroller
		adjustDuration: 808 milliSeconds
		start: 150 final: 200
		previousFinal: 433.

	self
		assert: aDjustedDuration
		equals: 50 milliSeconds.

	^ aDjustedDuration