Class {
	#name : #BlEllipticalArcCommand,
	#superclass : #BlCanvasPathCommand,
	#instVars : [
		'center',
		'phi',
		'radiiPoint',
		'startAngle',
		'sweepAngle'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlEllipticalArcCommand class >> from: fromPoint rotation: radiiPoint xAxisRotation: xAxisRotationInDegrees largeArcFlag: isLargeArc sweepFlag: isSweep to: toPoint [

	| x1 y1 x2 y2 dx2 dy2 rx ry coeff cx1 cy1 ux uy vx vy sign xPrime1 yPrime1 radical startAngle sweepAngle cx cy aCenter uySign phi cosAngle sinAngle |

	rx := radiiPoint x.
	ry := radiiPoint y.
	x1 := fromPoint x.
	y1 := fromPoint y.
	x2 := toPoint x.
	y2 := toPoint y.
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

	^ self new
		initializeCenter: aCenter phi: phi radiiPoint: radiiPoint startAngle: startAngle sweepAngle: sweepAngle;
		yourself
]

{ #category : #initialization }
BlEllipticalArcCommand >> initializeCenter: aCenter phi: aPhi radiiPoint: aRadiiPoint startAngle: aStartAngle sweepAngle: aSweepAngle [

	center := aCenter.
	phi := aPhi.
	radiiPoint := aRadiiPoint.
	startAngle := aStartAngle.
	sweepAngle := aSweepAngle
]
