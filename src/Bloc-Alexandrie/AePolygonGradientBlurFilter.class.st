"
I'm a gradient-based blur filter for polygons.
"
Class {
	#name : #AePolygonGradientBlurFilter,
	#superclass : #AeGradientBlurFilter,
	#instVars : [
		'sides',
		'vertices',
		'corners',
		'verticesInfo'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #private }
AePolygonGradientBlurFilter >> drawCoreOn: context [

	sides withIndexDo: [ :each :index |
		(each at: #isClockwise)
			ifTrue: [ context lineTo: (each at: #inside1) ]
			ifFalse: [
				| a b |
				a := (verticesInfo at: index) fourth.
				b := (verticesInfo at: index) fifth.
				context
					arcCenter: (each at: #inside1)
					radius: blurRadius * 2
					startAngle: a
					endAngle: b
					cw: false ]
		 ].
	context
		sourceColor: color;
		fill
]

{ #category : #private }
AePolygonGradientBlurFilter >> drawCorner: corner on: context [

	| aGradient |
	aGradient :=
		(corner at: #isClockwise)
			ifTrue: [
				(AeCairoRadialGradientPattern
					center: (corner at: #center)
					innerRadius: 0
					outerRadius: (corner at: #radius)) ]
			ifFalse: [
				(AeCairoRadialGradientPattern
					center: (corner at: #center)
					innerRadius: (corner at: #radius)
					outerRadius: 0) ].

	aGradient addStopsFrom: ramp.

		
	context
		moveTo: (corner at: #center);
		arcCenter: (corner at: #center)
			radius: (corner at: #radius)
			startAngle: (corner at: #angle1)
			endAngle: (corner at: #angle2)
			cw: (corner at: #isClockwise);
		closePath.
	context
		sourcePattern: aGradient;
		fillPreservingPath: false alpha: color alpha.

	aGradient externallyFree
]

{ #category : #drawing }
AePolygonGradientBlurFilter >> drawFragmentsOn: context [

	self drawCoreOn: context.
	sides do: [ :each | self drawSide: each on: context ].
	corners do: [ :each | self drawCorner: each on: context ]
]

{ #category : #private }
AePolygonGradientBlurFilter >> drawSide: aSide on: context [

	| aGradient |
	aGradient :=
		(aSide at: #isClockwise)
			ifTrue: [
				AeCairoLinearGradientPattern
					from: (aSide at: #inside1)
					to: (aSide at: #outside1) ]
			ifFalse: [
				AeCairoLinearGradientPattern
					from: (aSide at: #outside1)
					to: (aSide at: #inside1) ].
	aGradient addStopsFrom: ramp.

	context
		moveTo: (aSide at: #inside1);
		lineTo: (aSide at: #outside1);
		lineTo: (aSide at: #outside2);
		lineTo: (aSide at: #inside2);
		closePath.
	context
		sourcePattern: aGradient;
		fillPreservingPath: false alpha: color alpha.

	aGradient externallyFree
]

{ #category : #private }
AePolygonGradientBlurFilter >> roundedCornerP1: p1 p2: p2 p3: p3 [
	"Based on `RSAthensRenderer>>#applyRadius:on:from:to:`, which is based on
	https://riptutorial.com/html5-canvas/example/18766/render-a-rounded-polygon-"

	| v1 len1 a1 v2 len2 a2 sinA sin90 angle isClockwise halfAngle lenOut center a b sideNormal |
	(p1 = p2 or: [ p2 = p3 ]) ifTrue: [ ^ self error ].

	v1 := p1 - p2.
	len1 := v1 r.
	v1 := v1 / len1.
	a1 := v1 angle.

	v2 := p3 - p2.
	len2 := v2 r.
	v2 := v2 / len2.
	a2 := v2 angle.

	sinA := (v1 x * v2 y) - (v1 y * v2 x).
	sin90 := (v1 x * v2 x) - (v1 y * v2 y negated).
	angle := sinA arcSin.
	isClockwise := true.

	sin90 < 0.0
		ifTrue: [
			angle < 0.0
				ifTrue: [
					angle := angle + Float pi ]
				ifFalse: [
					angle := angle - Float pi.
					isClockwise := false ] ]
		ifFalse: [
			angle >= 0.0 ifTrue: [
				isClockwise := false ] ].

	halfAngle := angle / 2.0.
	sinA := halfAngle sin.
	lenOut := (sinA closeTo: 0.0)
		ifTrue: [ Float infinity ]
		ifFalse: [ (halfAngle cos * blurRadius / sinA) abs ].

	isClockwise
		ifTrue: [
			center := p2 + (v2 * lenOut) + ((v2 y negated @ v2 x) * blurRadius).
			a := a1 + Float halfPi.
			b := a2 - Float halfPi ]
		ifFalse: [
			center := p2 + (v2 * lenOut) - ((v2 y negated @ v2 x) * blurRadius).
			a := a1 - Float halfPi.
			b := a2 + Float halfPi ].

	sideNormal := Point r: blurRadius * 2 theta: b.


	^ { center. sideNormal. isClockwise. a. b }
]

{ #category : #initialization }
AePolygonGradientBlurFilter >> vertices: points [

	vertices := points.

	verticesInfo :=
		(1 to: vertices size) collect: [ :index |
			self
				roundedCornerP1: (vertices atWrap: index - 1)
				p2: (vertices at: index)
				p3: (vertices atWrap: index + 1) ].
	
	sides :=
		(1 to: vertices size) collect: [ :index |
			| inside nextInside normal isClockwise |
			inside := (verticesInfo at: index) first.
			normal := (verticesInfo at: index) second.
			nextInside := (verticesInfo atWrap: index + 1) first.
			(isClockwise := (verticesInfo at: index) third)
				ifFalse: [ nextInside := nextInside - normal ].
			(verticesInfo atWrap: index + 1) third
				ifFalse: [ nextInside := nextInside - normal ].

			{	#inside1 -> inside.
				#inside2 -> nextInside.
				#outside1 -> (inside + normal).
				#outside2 -> (nextInside + normal).
				#isClockwise -> isClockwise.
			} asOrderedDictionary	].

	corners :=
		verticesInfo collect: [ :each |		
			{	#angle1 -> each fourth.
				#angle2 -> each fifth.
				#radius -> (blurRadius * 2).
				#center -> each first.
				#isClockwise -> each third.
			} asOrderedDictionary ].

]
