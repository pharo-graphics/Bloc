Extension { #name : #BlBezierCurveGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		self aeDrawAccordingToControlPointsOn: cairoContext ]

]

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSBezier>>#basicIncludesPoint:"

	| lines ir |
	ir := aBlElement border width / 2.
	lines := self asPolylineVertices. "TODO: cache"

	^ (1 to: lines size - 1) anySatisfy: [ :i |
			aPoint 
				onLineFrom: (lines at: i)
				to: (lines at: i + 1)
				within: ir ]

]

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeDrawAccordingToControlPointsOn: cairoContext [
	"Based on RSAthensRenderer>>#buildBezierPath:"

	controlPoints size = 2 ifTrue: [ 
		cairoContext
			lineFrom: controlPoints first
			to: controlPoints second.
		^ self ].

	controlPoints size = 3 ifTrue: [ 
		cairoContext
			quadraticCurveFrom: controlPoints first
			controlPoint: controlPoints second 
			to: controlPoints third.
		^ self ].

	controlPoints size = 4 ifTrue: [ 
		cairoContext
			cubicCurveFrom: controlPoints first
			controlPoint1: controlPoints second 
			controlPoint2: controlPoints third 
			to: controlPoints fourth.
		^ self ].

	self notYetImplemented
]

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> asPolylineVertices [

	| c b a via1 via2 start end |
	controlPoints size = 2 ifTrue: [ 
		^ Array
			with: controlPoints first
			with: controlPoints second ].

	start := controlPoints first.
	via1 := controlPoints second.
	via2 := controlPoints third.
	end := controlPoints size = 3
       ifTrue: [ via2 ]
       ifFalse: [ controlPoints fourth ].
	c := 3 * (via1 - start).
	b := 3 * (via2 - via1) - c.
	a := end - start - c - b.

	^ (0.0 to: 1.0 by: 0.2) collect: [ :t | 
		  a * (t raisedTo: 3) + (b * (t * t)) + (c * t) + start ]
]
