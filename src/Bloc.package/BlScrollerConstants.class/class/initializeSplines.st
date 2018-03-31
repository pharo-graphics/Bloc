initialization
initializeSplines
	"Precomputes spline position and time
	https://en.wikipedia.org/wiki/Spline_interpolation
	https://github.com/android/platform_frameworks_base/blob/master/core/java/android/widget/OverScroller.java#L603"
	| xMin yMin |
	
	xMin := 0.0.
	yMin := 0.0.
	
	1 to: NbSamples do: [ :anIndex |
		| alpha xMax x dx yMax y dy coef break |
		alpha := (anIndex - 1) asFloat / NbSamples .
		coef := 0.0.
		
		xMax := 1.0.
		x := 0.0.
		dx := 0.0.
		break := false.
		[ break ] whileFalse: [ 
			x := xMin + ((xMax - xMin) / 2.0).
			coef := 3.0 * x * (1.0 - x).
			dx := coef * ((1.0 - x) * P1 + (x * P2)) + (x * x * x).
			(dx - alpha) abs < 0.00001
				ifTrue: [ break := true ]
				ifFalse: [ 
					dx > alpha
						ifTrue: [ xMax := x ]
						ifFalse: [ xMin := x ] ] ].
		SplinePosition at: anIndex put: coef * ((1.0 - x) * StartTension + x) + (x * x * x).
		
		yMax := 1.0.
		y := 0.
		dy := 0.
		break := false.
		[ break ] whileFalse: [ 
			y := yMin + ((yMax - yMin) / 2.0).
			coef := 3.0 * y * (1.0 - y).
			dy := coef * ((1.0 - y) * StartTension + y) + (y * y * y).
			(dy - alpha) abs < 0.00001
				ifTrue: [ break := true ]
				ifFalse: [ 
					dy > alpha
						ifTrue: [ yMax := y ]
						ifFalse: [ yMin := y ] ] ].
		SplineTime at: anIndex put: coef * ((1.0 - y) * P1 + (y * P2)) + (y * y * y) ].

	SplinePosition at: NbSamples + 1 put: 1.0.
	SplineTime at: NbSamples + 1 put: 1.0.