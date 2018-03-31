examples - physics
splineDeceleration
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.
	
	"spline deceleration depends on physical coefficient which depends on ppi"
	"velocity -> spline deceleration"
	aVelocityMapping := { 
		0 -> Float negativeInfinity.
		1 -> -7.196176620396506.
		2 -> -6.503029439836561.
		4 -> -5.809882259276615.
		8 -> -5.11673507871667.
		16 -> -4.4235878981567245.
		32 -> -3.7304407175967795.
		64 -> -3.037293537036834.
		128 -> -2.3441463564768887.
		256 -> -1.6509991759169433.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineDecelerationFor: anAssoc key) ].
	
	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].
		
	^ anActualMapping asOrderedDictionary