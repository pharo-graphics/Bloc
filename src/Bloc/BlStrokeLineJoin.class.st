"
I specify the shape to be used at the corners of paths or basic shapes when they are stroked.

https://www.w3.org/TR/SVG/painting.html#StrokeLinejoinProperty

Possible types are:
 - bevel: BlStrokeLineBevelJoin
 - miter: BlStrokeLineMiterJoin
 - round: BlStrokeLineRoundJoin

Evaluate to see a visual preview:
`= BlStrokeLineJoin new inspect `=

"
Class {
	#name : #BlStrokeLineJoin,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'bevel',
		'miter',
		'round'
	],
	#category : 'Bloc-Paint-Support'
}

{ #category : 'predefined instances' }
BlStrokeLineJoin class >> bevel [
	^ bevel ifNil: [ bevel := BlStrokeLineBevelJoin new ]
]

{ #category : 'cleanup' }
BlStrokeLineJoin class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.

	bevel := miter := round := nil
]

{ #category : 'accessing' }
BlStrokeLineJoin class >> joinName [
	^ self subclassResponsibility
]

{ #category : 'predefined instances' }
BlStrokeLineJoin class >> miter [
	^ miter ifNil: [ miter := BlStrokeLineMiterJoin new ]
]

{ #category : 'predefined instances' }
BlStrokeLineJoin class >> round [
	^ round ifNil: [ round := BlStrokeLineRoundJoin new ]
]

{ #category : 'printing' }
BlStrokeLineJoin >> printOn: aStream [

	self class ~= BlStrokeLineJoin
		ifTrue: [ aStream nextPutAll: self class joinName ]
		ifFalse: [ aStream nextPutAll: 'Line Join' ]
]
