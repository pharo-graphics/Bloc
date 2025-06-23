"
I'm an abstract filter to simulate blur via gradients.
"
Class {
	#name : #AeGradientBlurFilter,
	#superclass : #Object,
	#instVars : [
		'ramp',
		'color',
		'blurRadius'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #examples }
AeGradientBlurFilter class >> example [
	<sampleInstance>

	| blurSigma offset shadowColor a input circleCenter circleRadius mainContext polygonVertices rectangle roundedRectangle roundedRectangleRadii zoom mainSurface |
	blurSigma := 10.
	offset := -10.
	shadowColor := Color black alpha: 0.5.
	a := 80.

	input := {

	[
		circleCenter := a @ a.
		circleRadius := a / 2.
		AeCircleGradientBlurFilter new
			center: circleCenter
			radius: circleRadius;
			blurSigma: blurSigma
			color: shadowColor;
			drawOn: mainContext ] -> [
			mainContext circleCenter: circleCenter radius: circleRadius ].

	[
		polygonVertices := { 
			0   @ 0.
			a   @ a.
			a*2 @ 0.
			a*2 @ (a*2).
			0   @ (a*2) }.
		AePolygonGradientBlurFilter new
			blurSigma: blurSigma
			color: shadowColor;
			vertices: polygonVertices;
			drawOn: mainContext ] -> [
				polygonVertices do: [ :each | mainContext lineTo: each ].
				mainContext closePath ].

	[
		rectangle := 0@0 extent: (a * 2 @ a).
		AeRectangleGradientBlurFilter new
			blurSigma: blurSigma
			color: shadowColor;
			rectangle: rectangle;
			drawOn: mainContext ] -> [
				mainContext rectangle: rectangle ].

	[
		roundedRectangle := 0@0 extent: (a*2 @ a).
		roundedRectangleRadii := {a/3 * 0.25. a/3 * 0.75. a/3. 0 }.
		AeRoundedRectangleGradientBlurFilter new
			blurSigma: blurSigma
			color: shadowColor;
			rectangle: roundedRectangle
			radii: roundedRectangleRadii;
			drawOn: mainContext ] -> [ 
				mainContext
					roundedRectangleLeft: roundedRectangle left
					top: roundedRectangle top 
					right: roundedRectangle right
					bottom: roundedRectangle bottom
					tl: roundedRectangleRadii first
					tr: roundedRectangleRadii second
					br: roundedRectangleRadii third
					bl: roundedRectangleRadii fourth ]

	}.

	zoom := 1.25.
	mainSurface := AeCairoImageSurface
		extent: ((input size * a * 5) @ 500) * zoom
		format: AeCairoSurfaceFormat rgb24.
	mainSurface deviceScaleX: zoom y: zoom.
	mainContext := mainSurface newContext.
	mainContext sourceColor: Color paleOrange; paint.

	mainContext rotateByRadians: 15 degreesToRadians.


	input do: [ :each |

		each key value. "draw shadow"
		mainContext restoreStateAfter: [
			mainContext translateByX: offset y: offset.
			each value value. "apply shape path".
			mainContext
				sourceColor: "Color green translucent" Color transparent;
				fill ]

	 ] separatedBy: [ mainContext translateByX: a*2.5 y: 0.0 ].

	^ mainSurface asForm
]

{ #category : #accessing }
AeGradientBlurFilter >> blurRadius [

	^ blurRadius
]

{ #category : #initialization }
AeGradientBlurFilter >> blurRadius: aBlurRadius color: aColor [

	color := aColor.
	blurRadius := aBlurRadius.

	"The ramp defines all stops, playing with alpha channel"
	ramp := Array streamContents: [ :stream |
		self
			rampSize: blurRadius
			stopsAndAlphasDo: [ :eachStop :eachAlpha |
				stream nextPut: (eachStop -> (color alpha: eachAlpha)) ] ]
]

{ #category : #initialization }
AeGradientBlurFilter >> blurSigma: aBlurSigma color: aColor [

	self blurRadius: (aBlurSigma * 3) ceiling color: aColor
]

{ #category : #accessing }
AeGradientBlurFilter >> color [

	^ color
]

{ #category : #drawing }
AeGradientBlurFilter >> drawFragmentsOn: aContext [

	self subclassResponsibility
]

{ #category : #drawing }
AeGradientBlurFilter >> drawOn: context [

	context saveState.

	"Disable antialias to avoid unexpected seams between fragments"
	context antialias: AeCairoAntialias none.

	self drawFragmentsOn: context.
	
	context restoreState
]

{ #category : #accessing }
AeGradientBlurFilter >> ramp [

	^ ramp
]

{ #category : #initialization }
AeGradientBlurFilter >> rampFunctionAt: x [
	"Evaluate 1.0 minus a sigmoid (logistic) function, with mu and sigma determined manually by trial and error."

	^ 1.0 - (1.0 / (1.0 + (((x - 0.475) * -10.0) exp)))
]

{ #category : #initialization }
AeGradientBlurFilter >> rampSize: rampSize stopsAndAlphasDo: aBlock [

	aBlock value: 0.0 value: 1.0.

	1 to: rampSize - 2 do: [ :i |
		| stop |
		stop := i / (rampSize - 1) asFloat.
		aBlock
			value: stop
			value: (self rampFunctionAt: stop) ].

	aBlock value: 1.0 value: 0.0
]
