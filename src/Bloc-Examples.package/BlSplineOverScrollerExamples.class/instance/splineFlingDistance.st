examples - physics
splineFlingDistance
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.

	"velocity -> spline fling distance"
	aVelocityMapping := { 
		0 -> 0.0.
		1 -> 0.0017500093262010565.
		2 -> 0.005830543034945757.
		4 -> 0.01942574337940917.
		8 -> 0.06472115951823502.
		16 -> 0.2156328541756035.
		32 -> 0.718428534748616.
		64 -> 2.393603523518351.
		128 -> 7.974819415829869.
		256 -> 26.569874287958488.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDistanceFor: anAssoc key) ].
	
	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].
		
	^ anActualMapping asOrderedDictionary