"
I specifiy the shape to be used at the end of open subpaths when they are stroked.

https://www.w3.org/TR/SVG/painting.html#StrokeLinecapProperty

Possible types are:
 - butt: BlStrokeLineButtCap
 - round: BlStrokeLineRoundCap
 - square: BlStrokeLineSquareCap

Evaluate to see a visual preview:
`= BlStrokeLineCap new inspect `=

"
Class {
	#name : #BlStrokeLineCap,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'butt',
		'round',
		'square'
	],
	#category : 'Bloc-Paint-Support'
}

{ #category : 'predefined instances' }
BlStrokeLineCap class >> butt [
	^ butt ifNil: [ butt := BlStrokeLineButtCap new ]
]

{ #category : 'accessing' }
BlStrokeLineCap class >> capName [
	^ self subclassResponsibility
]

{ #category : 'cleanup' }
BlStrokeLineCap class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.

	square := round := butt := nil
]

{ #category : 'predefined instances' }
BlStrokeLineCap class >> round [
	^ round ifNil: [ round := BlStrokeLineRoundCap new ]
]

{ #category : 'predefined instances' }
BlStrokeLineCap class >> square [
	^ square ifNil: [ square := BlStrokeLineSquareCap new ]
]

{ #category : 'printing' }
BlStrokeLineCap >> printOn: aStream [

	self class ~= BlStrokeLineCap
		ifTrue: [ aStream nextPutAll: self class capName ]
		ifFalse: [ aStream nextPutAll: 'Line Cap' ]
]
