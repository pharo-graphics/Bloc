"
I'm a gradient-based blur filter for circles.
"
Class {
	#name : #AeCircleGradientBlurFilter,
	#superclass : #AeGradientBlurFilter,
	#instVars : [
		'circleCenter',
		'circleRadius'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #initialization }
AeCircleGradientBlurFilter >> center: aPoint radius: aCircleRadius [

	circleCenter := aPoint asIntegerPoint.
	circleRadius := aCircleRadius asInteger
]

{ #category : #drawing }
AeCircleGradientBlurFilter >> drawFragmentsOn: context [

	| aGradient |
	aGradient := AeCairoRadialGradientPattern
		center: circleCenter
		innerRadius: circleRadius - blurRadius
		outerRadius: circleRadius + blurRadius.
	aGradient addStopsFrom: ramp.

	context
		sourcePattern: aGradient;
		paintWithAlpha: color alpha.

	"Force free to include this time in the benchmarks"
	aGradient externallyFree
]
