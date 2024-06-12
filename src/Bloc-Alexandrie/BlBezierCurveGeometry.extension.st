Extension { #name : #BlBezierCurveGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		self aeDrawAccordingToControlPointsOn: cairoContext ]

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
			moveTo: controlPoints first;
			quadraticCurveFromCurrentPoint: controlPoints first
				via: controlPoints second
				to: controlPoints third.
		^ self ].

	controlPoints size = 4 ifTrue: [ 
		cairoContext
			moveTo: controlPoints first;
			curveVia: controlPoints second
				  via: controlPoints third
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
