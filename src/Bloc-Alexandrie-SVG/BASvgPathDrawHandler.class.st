Class {
	#name : #BASvgPathDrawHandler,
	#superclass : #Object,
	#instVars : [
		'cairoContext',
		'lastControlPoint',
		'currentPosition',
		'isAbsolute',
		'initialPathPosition'
	],
	#category : #'Bloc-Alexandrie-SVG'
}

{ #category : #'instance creation' }
BASvgPathDrawHandler class >> on: aeCairoContext [ 
	
	^ self basicNew
		initializeWith: aeCairoContext;
		yourself
]

{ #category : #API }
BASvgPathDrawHandler >> closePath [
	
	cairoContext closePath.
	
	self currentPosition: initialPathPosition.
	initialPathPosition := nil.
	lastControlPoint := nil
]

{ #category : #API }
BASvgPathDrawHandler >> cubicBezierVia: p1 and: p2 to: aPoint [

	| pt1 |
	pt1 := self toAbsolute: p1.
	lastControlPoint := self toAbsolute: p2.
	self currentPosition: (self toAbsolute: aPoint).

	cairoContext
		curveViaX: pt1 x
		y: pt1 y
		viaX: lastControlPoint x
		y: lastControlPoint y
		toX: currentPosition x
		y: currentPosition y
]

{ #category : #accessing }
BASvgPathDrawHandler >> currentPosition: aPoint [

	currentPosition := aPoint.
	initialPathPosition ifNil: [ initialPathPosition := aPoint ]
]

{ #category : #API }
BASvgPathDrawHandler >> ellipticalArcRotation: radiiPoint xAxisRotation: xAxisRotationInDegrees largeArcFlag: isLargeArc sweepFlag: isSweep to: toPosition [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataEllipticalArcCommands
	Based on Athens-SVG-PathConverter"

	| x1 y1 x2 y2 dx2 dy2 rx ry coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical startAngle sweepAngle cx cy absoluteToPosition aCenter uySign phi cosAngle sinAngle |

	absoluteToPosition := self toAbsolute: toPosition.

	rx := radiiPoint x.
	ry := radiiPoint y.
	x1 := currentPosition x.
	y1 := currentPosition y.
	x2 := absoluteToPosition x.
	y2 := absoluteToPosition y.
	dx2 := (x1 - x2) / 2.0.
	dy2 := (y1 - y2) / 2.0.

	phi := (xAxisRotationInDegrees \\ 360) degreesToRadians.
	cosAngle := phi cos.
	sinAngle := phi sin.
	xPrime1 := cosAngle * dx2 + (sinAngle * dy2).
	yPrime1 := cosAngle * dy2 - (sinAngle * dx2).

	"Step 2: Compute (cx1, cy1) "
	radical :=
		(rx squared * ry squared
			- (rx squared * yPrime1 squared)
			- (ry squared * xPrime1 squared))
				/ (rx squared * yPrime1 squared + (ry squared * xPrime1 squared)).
	(radical closeTo: 0.0)
		ifTrue: [
			radical := 0.0.
			coeff := 0.0 ]
		ifFalse: [
			coeff := radical abs sqrt ].
	isSweep = isLargeArc ifTrue: [ coeff := coeff negated ].
	cx1 := coeff * yPrime1.
	cy1 := (coeff * xPrime1) negated.

	"Step 3: Compute (cx, cy)"
	cx := cosAngle * cx1 - (sinAngle * cy1) + ((x1 + x2) / 2.0).
	cy := sinAngle * cx1 + (cosAngle * cy1) + ((y1 + y2) / 2.0).
	aCenter := cx @ cy.
		
	"Step 4: Compute startAngle and sweepAngle"
	ux := (xPrime1 - cx1) / rx.
	uy := (yPrime1 - cy1) / ry.
	vx := (xPrime1 negated - cx1) / rx.
	vy := (yPrime1 negated - cy1) / ry.
	sign := ux * vy - (uy * vx) <= 0.0
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	uySign := uy = 0
		ifTrue: [ 1 ]
		ifFalse: [ uy sign ].
	startAngle :=
		((ux / (ux squared + uy squared) sqrt) arcCos * uySign)
			radiansToDegrees \\ 360.
	sweepAngle :=
		(((ux * vx + (uy * vy))
			/ ((ux squared + uy squared) * (vx squared + vy squared)) abs sqrt)
			asFloat arcCos * sign) radiansToDegrees \\ 360.
	(isLargeArc and: [ sweepAngle abs < 180 ]) ifTrue: [
		sweepAngle := sweepAngle negative
			ifTrue: [ 360 + sweepAngle ]
			ifFalse: [ sweepAngle - 360 ]].
	isSweep
		ifTrue: [ sweepAngle < 0 ifTrue: [ sweepAngle := sweepAngle + 360 ]]
		ifFalse: [ sweepAngle > 0 ifTrue: [ sweepAngle := sweepAngle - 360 ]].

	cairoContext restoreStateAfter: [
		"Rotate around center"
		cairoContext
			translateBy: aCenter;
			rotateByRadians: phi;
			translateBy: aCenter negated.

		"Inspired on: https://www.cairographics.org/cookbook/ellipses/"
		cairoContext
			translateBy: aCenter - radiiPoint;
			scaleBy: radiiPoint.

		cairoContext
			arcCenter: 1.0 @ 1.0
	 			radius: 1.0
				startAngle: startAngle degreesToRadians
				sweep: sweepAngle degreesToRadians ].

	self currentPosition: absoluteToPosition
]

{ #category : #API }
BASvgPathDrawHandler >> horizontalLineTo: x [

	self lineTo:
		(isAbsolute
			 ifTrue: [ x @ currentPosition y ]
			 ifFalse: [ x @ 0 ])
]

{ #category : #initialization }
BASvgPathDrawHandler >> initializeWith: aeCairoContext [ 
	
	self initialize.
	
	currentPosition := 0.0 @ 0.0.
	lastControlPoint := nil.
	cairoContext := aeCairoContext
]

{ #category : #testing }
BASvgPathDrawHandler >> isAbsolute: aBoolean [

	isAbsolute := aBoolean
]

{ #category : #API }
BASvgPathDrawHandler >> lineTo: aPoint [

	lastControlPoint := nil.
	self currentPosition: (self toAbsolute: aPoint).
	
	cairoContext lineTo: currentPosition
]

{ #category : #API }
BASvgPathDrawHandler >> moveTo: aPoint [

	lastControlPoint := nil.
	self currentPosition: (self toAbsolute: aPoint).

	cairoContext moveTo: currentPosition
]

{ #category : #API }
BASvgPathDrawHandler >> quadraticBezierVia: p1 to: aPoint [

	| startPoint |
	startPoint := currentPosition.
	lastControlPoint := self toAbsolute: p1.
	self currentPosition: (self toAbsolute: aPoint).

	cairoContext
		quadraticCurveFromCurrentPoint: startPoint
		via: lastControlPoint
		to: currentPosition
]

{ #category : #API }
BASvgPathDrawHandler >> smoothCubicBezierVia: p2 to: aPoint [

	| startPoint firstControlPoint |
	startPoint := currentPosition.
	firstControlPoint :=
		lastControlPoint
	       ifNil: [ startPoint ]
	       ifNotNil: [ startPoint * 2 - lastControlPoint ].
	lastControlPoint := self toAbsolute: p2.
	self currentPosition: (self toAbsolute: aPoint).

	cairoContext
		curveVia: firstControlPoint
		via: lastControlPoint
		to: currentPosition
]

{ #category : #API }
BASvgPathDrawHandler >> smoothQuadraticBezierTo: aPoint [

	| startPoint |
	startPoint := currentPosition.
	lastControlPoint :=
		lastControlPoint
			ifNil: [ startPoint ]
			ifNotNil: [ startPoint * 2 - lastControlPoint ].
	self currentPosition: (self toAbsolute: aPoint).

	cairoContext
		quadraticCurveFromCurrentPoint: startPoint
		via: lastControlPoint
		to: currentPosition
]

{ #category : #private }
BASvgPathDrawHandler >> toAbsolute: aPoint [

	^ isAbsolute
		  ifTrue: [ aPoint ]
		  ifFalse: [ currentPosition + aPoint ]
]

{ #category : #API }
BASvgPathDrawHandler >> verticalLineTo: y [

	self lineTo:
		(isAbsolute
			 ifTrue: [ currentPosition x @ y ]
			 ifFalse: [ 0 @ y ])
]
