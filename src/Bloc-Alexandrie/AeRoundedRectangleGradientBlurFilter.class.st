"
I'm a gradient-based blur filter for rounded rectangles.
"
Class {
	#name : #AeRoundedRectangleGradientBlurFilter,
	#superclass : #AeGradientBlurFilter,
	#instVars : [
		'radii',
		'blurSides',
		'blurCorners',
		'rectangle'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #private }
AeRoundedRectangleGradientBlurFilter >> drawCoreOn: context [

	context
		sourceColor: color;

		moveTo: blurCorners first first;
		lineTo: (blurSides first at: #clipArea) bottomLeft;
		lineTo: (blurSides first at: #clipArea) bottomRight;

		lineTo: blurCorners second first;
		lineTo: (blurSides second at: #clipArea) topLeft;
		lineTo: (blurSides second at: #clipArea) bottomLeft;

		lineTo: blurCorners third first;
		lineTo: (blurSides third at: #clipArea) topRight;
		lineTo: (blurSides third at: #clipArea) topLeft;

		lineTo: blurCorners fourth first;
		lineTo: (blurSides fourth at: #clipArea) bottomRight;
		lineTo: (blurSides fourth at: #clipArea) topRight;
		closePath;

		fill
]

{ #category : #private }
AeRoundedRectangleGradientBlurFilter >> drawCornersOn: context [

	blurCorners do: [ :each |
		| aGradient |
		aGradient := AeCairoRadialGradientPattern
			center: each first
			innerRadius: each second - blurRadius
			outerRadius: each second + blurRadius.
		aGradient addStopsFrom: ramp.

		context
			sourcePattern: aGradient;
			rectangle: each third;
			fillPreservingPath: false alpha: color alpha.

		"Force free to include this time in the benchmarks"
		aGradient externallyFree ]
]

{ #category : #drawing }
AeRoundedRectangleGradientBlurFilter >> drawFragmentsOn: context [

	self
		drawSidesOn: context;
		drawCornersOn: context;
		drawCoreOn: context
]

{ #category : #private }
AeRoundedRectangleGradientBlurFilter >> drawSidesOn: context [

	blurSides do: [ :each |
		| aGradient |
		aGradient :=
			AeCairoLinearGradientPattern
				from: (each at: #gradientFrom)
				to: (each at: #gradientTo)
				addStopsFrom: ramp.
	
		context
			sourcePattern: aGradient;
			rectangle: (each at: #clipArea);
			fillPreservingPath: false alpha: color alpha.

		"Force free to include this time in the benchmarks"
		aGradient externallyFree ]
]

{ #category : #initialization }
AeRoundedRectangleGradientBlurFilter >> rectangle: aRectangle radii: anArray [
	"radii: topLeft, topRight, bottomRight, bottomLeft"

	rectangle := aRectangle.
	radii := anArray.
	

	"-- sides --"

	blurSides := {
		{	#gradientFrom -> (0 @ (rectangle top + blurRadius)).
			#gradientTo   -> (0 @ (rectangle top - blurRadius)).
			#clipArea ->
				(Rectangle
					left:   rectangle left  + (radii first  max: blurRadius)
					right:  rectangle right - (radii second max: blurRadius)
					top:    rectangle top - blurRadius
					bottom: rectangle top + blurRadius).
			#inset -> (radii first  max: blurRadius) } asOrderedDictionary.

		{	#gradientFrom -> ((rectangle right - blurRadius) @ 0).
			#gradientTo   -> ((rectangle right + blurRadius) @ 0).
		 	#clipArea ->
				(Rectangle
					left:   rectangle right - blurRadius
					right:  rectangle right + blurRadius
					top:    rectangle top    + (radii second max: blurRadius)
					bottom: rectangle bottom - (radii third  max: blurRadius)).
			#inset -> (radii second max: blurRadius) } asOrderedDictionary.

		{	#gradientFrom -> (0 @ (rectangle bottom - blurRadius)).
			#gradientTo   -> (0 @ (rectangle bottom + blurRadius)).
		 	#clipArea ->
				(Rectangle
					left:   rectangle left  + (radii fourth max: blurRadius)
					right:  rectangle right - (radii third  max: blurRadius)
					top:    rectangle bottom - blurRadius
					bottom: rectangle bottom + blurRadius).
			#inset -> (radii third  max: blurRadius) } asOrderedDictionary.

		{	#gradientFrom -> ((rectangle left + blurRadius) @ 0).
			#gradientTo   -> ((rectangle left - blurRadius) @ 0).
		 	#clipArea ->
				(Rectangle
					left:   rectangle left - blurRadius
					right:  rectangle left + blurRadius
					top:    rectangle top    + (radii first  max: blurRadius)
					bottom: rectangle bottom - (radii fourth max: blurRadius)).
			#inset -> (radii fourth max: blurRadius) } asOrderedDictionary.
		}.
		

	"-- corners --"
	
	blurCorners := Array new: 4 streamContents: [ :stream |
		| gradientCenter |

		stream nextPut: {
			gradientCenter :=
				(blurSides first at: #clipArea) left
				@ (blurSides fourth at: #clipArea) top.
			blurSides first at: #inset.
			Rectangle
				left: rectangle left - blurRadius
				right: gradientCenter x
				top: rectangle top - blurRadius
				bottom: gradientCenter y }.

		stream nextPut: {
			gradientCenter :=
				(blurSides first at: #clipArea) right
				@ (blurSides second at: #clipArea) top.
			blurSides second at: #inset.
			Rectangle
				left: gradientCenter x
				right: rectangle right + blurRadius
				top: rectangle top - blurRadius
				bottom: gradientCenter y }.

		stream nextPut: {
			gradientCenter :=
				(blurSides third at: #clipArea) right
				@ (blurSides second at: #clipArea) bottom.
			blurSides third at: #inset.
			Rectangle
				left: gradientCenter x
				right: rectangle right + blurRadius
				top: gradientCenter y
				bottom: rectangle bottom + blurRadius }.

		stream nextPut: {
			gradientCenter :=
				(blurSides third at: #clipArea) left
				@ (blurSides fourth at: #clipArea) bottom.
			blurSides fourth at: #inset.
			Rectangle
				left: rectangle left - blurRadius
				right: gradientCenter x
				top: gradientCenter y
				bottom: rectangle bottom + blurRadius }.

		]
]
