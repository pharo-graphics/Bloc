Extension { #name : #SpartaCairoPathBuilder }

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> angleBetweenVector: u andVector: v [
	| sign scalarProduct acos |
	
	sign := (u x)*(v y)-((u y)*(v x)) sign.
	
	scalarProduct := (u x)*(v x)+((u y)*(v y)).
	acos :=  (scalarProduct / ((u dist:0@0) * (v dist:0@0))) arcCos.
	
	^ sign*acos
]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> curveVia: p1 to: aPoint [
	| pt0 cp1 cp2 twoThirds |
	"Quad bezier curve"

	pt0 := endPoint.
	lastControlPoint := self toAbsolute: p1.
	endPoint := self toAbsolute: aPoint.

"Any quadratic spline can be expressed as a cubic (where the cubic term is zero). The end points of the cubic will be the same as the quadratic's.

	CP0 = QP0
	CP3 = QP2

The two control points for the cubic are:

	CP1 = QP0 + 2/3 *(QP1-QP0)
	CP2 = QP2 + 2/3 *(QP1-QP2)"

	twoThirds := (2/3) asFloat.

	cp1 := (lastControlPoint - pt0) * twoThirds + pt0.
	cp2 := (lastControlPoint - endPoint) * twoThirds + endPoint.

	self primCurveViaX: cp1 x Y: cp1 y viaX: cp2 x Y: cp2 y toX: endPoint x Y: endPoint y
]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> ellipticalArc: radii xrot: rotationAxis large: largeFlag sweep: sweepFlag to: aPoint [
	|center startAngle endAngle x y cx cy cosAxis sinAxis factor|
	self flag:'Does not work properly yet'.
	cosAxis := rotationAxis degreeCos.
	sinAxis := rotationAxis degreeSin.
	
	"Conversion from endpoint to center parameterization"
	x := cosAxis*(endPoint x - (aPoint x))/2 + ( sinAxis*(endPoint y - (aPoint y))/2 ).
	y := (0-sinAxis)*(endPoint x - (aPoint x))/2 + ( cosAxis*(endPoint y - (aPoint y))/2 ).
	
	factor := ( ((radii x squared)*(radii y squared)) - ((radii x squared)*(y squared)) - ((radii y squared)*(x squared)) ) / ( ((radii x squared)*(y squared)) + ((radii y squared)*(x squared)) ) sqrt.
	largeFlag = sweepFlag ifFalse:[cx := factor*(radii x)*y/(radii y).
											cy := (factor*(radii y)*x/(radii x)) negated.]
		ifTrue:[cx := (factor*(radii x)*y/(radii y)) negated.
				cy := factor*(radii y)*x/(radii x).].
	self flag:'The center is off'.
	center := ((endPoint x + (aPoint x))/2) + (cosAxis*cx) - (sinAxis*cy) @ ((endPoint y + (aPoint y))/2) + (sinAxis*cx) + (cosAxis*cy).
	Transcript cr; show:center.
	
	startAngle := self angleOfVector: ( ((x-cx)/radii x) @ ((y-cy)/radii y) ).
	endAngle := self angleOfVector: ( ((0-x-cx)/radii x) @ ((0-y-cy)/radii y) ).
		
	"Translating and Scaling context to achieve an elliptical arc instead of a circular arc, thus making radii x the appropriate radius"
	self primTranslateByX: center x AndY: center y.
	self primScaleContextByX: 1 AndY: (radii y / (radii x)).
	
	sweepFlag = 0 ifFalse:[ self primArcCenterX: 0 centerY: 0 radius: radii x startAngle: startAngle endAngle: endAngle ]
		ifTrue:[ self primArcNegativeCenterX: 0 centerY: 0 radius: radii x startAngle: startAngle endAngle: endAngle ].
		
	"Reverting the changes to the context"
	self primScaleContextByX: 1 AndY: (radii x / (radii y)).
	self primTranslateByX: center x negated AndY: center y negated.
	
	"Adjusting endPoint and lastControlPoint"
	lastControlPoint := nil.
	endPoint := aPoint.
]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> primScaleContextByX: factorX AndY: factorY [

	self ffiCall: #(void cairo_scale (
			SpartaCairoCanvas canvas,
			double factorX,
			double factorY) )
]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> primTranslateByX: distanceX AndY: distanceY [

	self ffiCall: #(void cairo_translate (
			SpartaCairoCanvas canvas,
			double distanceX,
			double distanceY) )
]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> reflectedCurveTo: aPoint [
	| pt0 cp1 cp2 twoThirds |
	"Quad bezier curve"

	pt0 := endPoint.
	lastControlPoint := lastControlPoint
		ifNil: [ endPoint ]
		ifNotNil: [ endPoint * 2 - lastControlPoint].
	endPoint := self toAbsolute: aPoint.

"Any quadratic spline can be expressed as a cubic (where the cubic term is zero). The end points of the cubic will be the same as the quadratic's.

	CP0 = QP0
	CP3 = QP2

The two control points for the cubic are:

	CP1 = QP0 + 2/3 *(QP1-QP0)
	CP2 = QP2 + 2/3 *(QP1-QP2)"

	twoThirds := (2/3) asFloat.

	cp1 := (lastControlPoint - pt0) * twoThirds + pt0.
	cp2 := (lastControlPoint - endPoint) * twoThirds + endPoint.

	self primCurveViaX: cp1 x Y: cp1 y viaX: cp2 x Y: cp2 y toX: endPoint x Y: endPoint y

]

{ #category : #'*Bloc-SVG' }
SpartaCairoPathBuilder >> reflectedCurveVia: p2 to: aPoint [
	|  pt1 |

	pt1 := lastControlPoint
		ifNil: [ endPoint ]
		ifNotNil: [ endPoint * 2 - lastControlPoint].
	lastControlPoint := self toAbsolute: p2.
	endPoint := self toAbsolute: aPoint.

	self primCurveViaX: pt1 x Y: pt1 y viaX: lastControlPoint x Y: lastControlPoint y toX: endPoint x Y: endPoint y
]
