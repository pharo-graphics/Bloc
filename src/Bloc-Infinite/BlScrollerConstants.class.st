"
Constants for the scroll flinger algorithm.

See `BlScrollFlinger`
"
Class {
	#name : #BlScrollerConstants,
	#superclass : #SharedPool,
	#classVars : [
		'Ballistic',
		'Cubic',
		'DecelerationRate',
		'EndTension',
		'Gravity',
		'GravityEarth',
		'Inflexion',
		'NbSamples',
		'P1',
		'P2',
		'ScrollFriction',
		'Spline',
		'SplinePosition',
		'SplineTime',
		'StartTension'
	],
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #'class initialization' }
BlScrollerConstants class >> initialize [
	
	DecelerationRate := 0.78 log / 0.9 log.
	Gravity := 2000.0.
	GravityEarth := 9.80665.
	ScrollFriction := 0.015.
	Inflexion := 0.35.
	StartTension := 0.5.
	EndTension := 1.0.
	P1 := StartTension * Inflexion.
	P2 := 1.0 - (EndTension * (1.0 - Inflexion)).
	NbSamples := 100.
	SplinePosition := Array new: NbSamples + 1.
	SplineTime := Array new: NbSamples + 1.

	Spline := BlSplineOverScrollerStep spline.
	Cubic := BlSplineOverScrollerStep cubic.
	Ballistic := BlSplineOverScrollerStep ballistic.
	
	self initializeSplines
]

{ #category : #initialization }
BlScrollerConstants class >> initializeSplines [
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
	SplineTime at: NbSamples + 1 put: 1.0
]
