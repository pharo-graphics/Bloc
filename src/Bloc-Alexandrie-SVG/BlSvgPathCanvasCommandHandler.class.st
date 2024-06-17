Class {
	#name : #BlSvgPathCanvasCommandHandler,
	#superclass : #Object,
	#instVars : [
		'lastControlPoint',
		'currentPosition',
		'isAbsolute',
		'commands',
		'initialPosition'
	],
	#category : #'Bloc-Alexandrie-SVG'
}

{ #category : #API }
BlSvgPathCanvasCommandHandler >> closePath [
	
	self ensureResetLastControlPoint.

	currentPosition := initialPosition.
	initialPosition := nil.

	commands add: BlCloseCommand new
]

{ #category : #accessing }
BlSvgPathCanvasCommandHandler >> commands [

	^ commands
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> cubicBezierVia: p1 and: p2 to: aPoint [

	| pt1 |
	pt1 := self toAbsolute: p1.
	lastControlPoint := self toAbsolute: p2.
	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.

	commands add:
		(BlCubicBezierCommand
			from: pt1
			controlPoint: lastControlPoint
			to: currentPosition)
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> ellipticalArcRotation: radiiPoint xAxisRotation: xAxisRotationInDegrees largeArcFlag: isLargeArc sweepFlag: isSweep to: toPosition [

	| startPosition |
	self ensureResetLastControlPoint.

	startPosition := currentPosition.
	currentPosition := self toAbsolute: toPosition.
	self ensureRememberInitialPosition.

	commands add: (BlEllipticalArcCommand
		from: startPosition
		rotation: radiiPoint
		xAxisRotation: xAxisRotationInDegrees
		largeArcFlag: isLargeArc
		sweepFlag: isSweep
		to: currentPosition)
]

{ #category : #private }
BlSvgPathCanvasCommandHandler >> ensureRememberInitialPosition [

	initialPosition ifNotNil: [ ^ self ].
	initialPosition := currentPosition
]

{ #category : #private }
BlSvgPathCanvasCommandHandler >> ensureResetLastControlPoint [

	lastControlPoint := nil
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> horizontalLineTo: x [

	self ensureResetLastControlPoint.

	currentPosition :=
		isAbsolute
			ifTrue: [ x @ currentPosition y ]
			ifFalse: [ (x + currentPosition x) @ currentPosition y ].
	self ensureRememberInitialPosition.

	commands add: (BlLineCommand to: currentPosition)
]

{ #category : #initialization }
BlSvgPathCanvasCommandHandler >> initialize [

	super initialize.

	commands := OrderedCollection new.

	currentPosition := 0.0 @ 0.0.
	initialPosition := nil.
	lastControlPoint := nil

]

{ #category : #accessing }
BlSvgPathCanvasCommandHandler >> isAbsolute: aBoolean [

	isAbsolute := aBoolean
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> lineTo: aPoint [

	self ensureResetLastControlPoint.

	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.
	
	commands add: (BlLineCommand to: currentPosition)
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> moveTo: aPoint [

	self ensureResetLastControlPoint.

	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.

	commands add: (BlMoveCommand to: currentPosition)
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> quadraticBezierVia: p1 to: aPoint [

	| startPoint |
	startPoint := currentPosition.
	lastControlPoint := self toAbsolute: p1.
	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.

	commands add: (BlQuadraticBezierCommand
		from: startPoint
		controlPoint: lastControlPoint
		to: currentPosition)
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> smoothCubicBezierVia: p2 to: aPoint [

	| startPoint firstControlPoint |
	startPoint := currentPosition.
	firstControlPoint :=
		lastControlPoint
			ifNil: [ startPoint ]
			ifNotNil: [ startPoint * 2 - lastControlPoint ].
	lastControlPoint := self toAbsolute: p2.
	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.

	commands add: (BlCubicBezierCommand
		from: firstControlPoint
		controlPoint: lastControlPoint
		to: currentPosition)
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> smoothQuadraticBezierTo: aPoint [

	| startPoint |
	startPoint := currentPosition.
	lastControlPoint :=
		lastControlPoint
			ifNil: [ startPoint ]
			ifNotNil: [ startPoint * 2 - lastControlPoint ].
	currentPosition := self toAbsolute: aPoint.
	self ensureRememberInitialPosition.

	commands add: (BlQuadraticBezierCommand
		from: startPoint
		controlPoint: lastControlPoint
		to: currentPosition)
]

{ #category : #private }
BlSvgPathCanvasCommandHandler >> toAbsolute: aPoint [

	^ isAbsolute
		  ifTrue: [ aPoint ]
		  ifFalse: [ currentPosition + aPoint ]
]

{ #category : #API }
BlSvgPathCanvasCommandHandler >> verticalLineTo: y [

	self ensureResetLastControlPoint.

	currentPosition :=
		isAbsolute
			ifTrue: [ currentPosition x @ y ]
			ifFalse: [ 0 @ y ].
	self ensureRememberInitialPosition.

	commands add: (BlLineCommand to: currentPosition)
]
