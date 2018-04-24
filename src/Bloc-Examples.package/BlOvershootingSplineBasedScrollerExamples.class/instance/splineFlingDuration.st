examples - physics
splineFlingDuration
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.

	"velocity -> spline fling distance"
	aVelocityMapping := { 
		0 -> 0 milliSeconds.
		1 -> 5 milliSeconds.
		2 -> 8 milliSeconds.
		4 -> 13 milliSeconds.
		8 -> 23 milliSeconds.
		16 -> 38 milliSeconds.
		32 -> 64 milliSeconds.
		64 -> 106 milliSeconds.
		128 -> 178 milliSeconds.
		256 -> 296 milliSeconds.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDurationFor: anAssoc key) ].
	
	self
		assert: anActualMapping
		equals: aVelocityMapping.
		
	^ anActualMapping asOrderedDictionary