"
I'm a gradient-based blur filter for rectangles.
"
Class {
	#name : #AeRectangleGradientBlurFilter,
	#superclass : #AeGradientBlurFilter,
	#instVars : [
		'rectangle',
		'core',
		'blurCorners',
		'blurSides',
		'blurRadius2'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #private }
AeRectangleGradientBlurFilter >> drawCoreOn: context [

	context
		sourceColor: color;
		rectangle: core;
		fill
]

{ #category : #private }
AeRectangleGradientBlurFilter >> drawCornersOn: context [

	| aGradient aMatrix |
	aGradient :=
		AeCairoRadialGradientPattern
			innerX: 0.0
			innerY: 0.0
			innerRadius: 0.0
			outerX: 0.0
			outerY: 0.0
			outerRadius: blurRadius2.
	aGradient addStopsFrom: ramp.
	context sourcePattern: aGradient.

	aMatrix := AeCairoMatrix new.
	blurCorners do: [ :each |
		aMatrix beTranslationBy: each first negated.
		aGradient matrix: aMatrix.
		context
			rectangle: each second;
			fillPreservingPath: false
			alpha: color alpha ].

	"Force free to include this time in the benchmarks"
	aGradient externallyFree.
	aMatrix free
]

{ #category : #drawing }
AeRectangleGradientBlurFilter >> drawFragmentsOn: context [

	self
		drawCoreOn: context;
		drawSidesOn: context;
		drawCornersOn: context
]

{ #category : #private }
AeRectangleGradientBlurFilter >> drawSidesOn: context [

	blurSides do: [ :each |
		| aGradient |
		aGradient :=
			AeCairoLinearGradientPattern
				from: each first
				to: each second
				addStopsFrom: ramp.
	
		context
			sourcePattern: aGradient;
			rectangle: each third;
			fillPreservingPath: false alpha: color alpha.

		"Force free to include this time in the benchmarks"
		aGradient externallyFree ]
]

{ #category : #initialization }
AeRectangleGradientBlurFilter >> rectangle: aRectangle [
	
	blurRadius2 := blurRadius*2.

	rectangle := aRectangle.
	core := rectangle insetBy: blurRadius.


	blurCorners := {
		{	core topLeft.
			Rectangle
				left: core left - blurRadius2
				right: core left
				top: core top - blurRadius2
				bottom: core top }.
		{	core topRight.
			Rectangle
				left: core right
				right: core right + blurRadius2
				top: core top - blurRadius2
				bottom: core top }.
		{	core bottomRight.
			Rectangle
				left: core right
				right: core right + blurRadius2
				top: core bottom
				bottom: core bottom + blurRadius2 }.
		{	core bottomLeft.
			Rectangle
				left: core left - blurRadius2
				right: core left
				top: core bottom
				bottom: core bottom + blurRadius2 }.
		}.
	
	blurSides := {
		{	0 @ core top.
			0 @ (core top - blurRadius2).
		 	(Rectangle
				left: core left
				right: core right
				top: core top - blurRadius2
				bottom: core top) }.
		{	core right @ 0.
			(core right + blurRadius2) @ 0.
		 	(Rectangle
				left: core right
				right: core right + blurRadius2
				top: core top
				bottom: core bottom) }.
		{	0 @ core bottom.
			0 @ (core bottom + blurRadius2).
		 	(Rectangle
				left: core left
				right: core right
				top: core bottom
				bottom: core bottom + blurRadius2) }.
		{	core left @ 0.
			(core left - blurRadius2) @ 0.
		 	(Rectangle
				left: core left - blurRadius2
				right: core left
				top: core top
				bottom: core bottom) }.
		}
]
