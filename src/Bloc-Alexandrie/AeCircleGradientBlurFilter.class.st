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
AeCircleGradientBlurFilter >> drawFragments00On: context [

	self
		drawRectangleOn: context
		cornersRadius: circleRadius
		left: circleCenter x
		top: circleCenter y
		right: circleCenter x
		bottom: circleCenter y
]

{ #category : #drawing }
AeCircleGradientBlurFilter >> drawFragments1On: context [

	| maskSurface maskContext aGradient aMatrix outerRadius |
	aGradient := AeCairoRadialGradientPattern
		innerX: 0.0
		innerY: 0.0
		innerRadius: circleRadius - blurRadius
		outerX: 0.0
		outerY: 0.0
		outerRadius: (outerRadius := circleRadius + blurRadius).
	aGradient addStopsFrom: ramp.
	
	maskSurface := AeCairoImageSurface
		newWithFormat: AeCairoSurfaceFormat a8
		width: outerRadius ceiling
		height: outerRadius ceiling.
	maskContext := maskSurface newContext.
	maskContext sourcePattern: aGradient; paint.

	context sourceColor: color.

	"Bottom right"
	context
		maskSurface: maskSurface
			x: circleCenter x
			y: circleCenter y.

	"Bottom left"
	aMatrix := AeCairoMatrix new.
	aMatrix beFlipHorizontallyAround: 0.0.
	context
		matrix: aMatrix;
		maskSurface: maskSurface
			x: circleCenter x negated
			y: circleCenter y.

	"Top left"
	aMatrix beFlipBothAroundX: 0.0 y: 0.0.
	context
		matrix: aMatrix;
		maskSurface: maskSurface
			x: circleCenter x negated
			y: circleCenter y negated.

	"Top right"
	aMatrix beFlipVerticallyAround: 0.0.
	context
		matrix: aMatrix;
		maskSurface: maskSurface
			x: circleCenter x
			y: circleCenter y negated.

	"Force free to include this time in the benchmarks"
	aMatrix free.
	aGradient externallyFree.
	maskContext externallyFree.
	maskSurface externallyFree
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
