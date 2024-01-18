Class {
	#name : 'BLCursor',
	#superclass : 'Object',
	#category : 'Bloc-Utilities - Selection',
	#package : 'Bloc',
	#tag : 'Utilities - Selection'
}

{ #category : 'accessing' }
BLCursor class >> crosshair [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv crosshair' -> 'Cursor crosshair'.
	^ Cursor crossHair
]

{ #category : 'accessing' }
BLCursor class >> default [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv default' -> 'Cursor normal'.
	^ Cursor normal
]

{ #category : 'accessing' }
BLCursor class >> hand [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv hand' -> 'Cursor webLink'.
	^ Cursor webLink
]

{ #category : 'testing' }
BLCursor class >> isDeprecated [

	^ true
]

{ #category : 'accessing' }
BLCursor class >> overEditableText [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv overEditableText' -> 'Cursor overEditableText'.
	^ Cursor overEditableText
]

{ #category : 'accessing' }
BLCursor class >> resizeBottom [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottom' -> 'Cursor resizeBottom'.
	^ Cursor resizeBottom
]

{ #category : 'accessing' }
BLCursor class >> resizeBottomLeft [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottomLeft' -> 'Cursor resizeBottomLeft'.
	^ Cursor resizeBottomLeft
]

{ #category : 'accessing' }
BLCursor class >> resizeBottomRight [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottomRight' -> 'Cursor resizeBottomRight'.
	^ Cursor resizeBottomRight
]

{ #category : 'accessing' }
BLCursor class >> resizeTop [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTop' -> 'Cursor resizeTop'.
	^ Cursor resizeTop
]

{ #category : 'accessing' }
BLCursor class >> resizeTopLeft [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTopLeft' -> 'Cursor resizeTopLeft'.
	^ Cursor resizeTopLeft
]

{ #category : 'accessing' }
BLCursor class >> resizeTopRight [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTopRight' -> 'Cursor resizeTopRight'.
	^ Cursor resizeTopRight
]

{ #category : 'accessing' }
BLCursor class >> wait [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv wait' -> 'Cursor wait'.
	^ Cursor wait
]
