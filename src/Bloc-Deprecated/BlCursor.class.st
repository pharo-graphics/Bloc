Class {
	#name : #BlCursor,
	#superclass : #Object,
	#category : #'Bloc-Deprecated-Utilities - Selection'
}

{ #category : #accessing }
BlCursor class >> crosshair [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv crosshair' -> 'Cursor crossHair'.
	^ Cursor crossHair
]

{ #category : #accessing }
BlCursor class >> default [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv default' -> 'Cursor normal'.
	^ Cursor normal
]

{ #category : #accessing }
BlCursor class >> hand [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv hand' -> 'Cursor webLink'.
	^ Cursor webLink
]

{ #category : #testing }
BlCursor class >> isDeprecated [

	^ true
]

{ #category : #accessing }
BlCursor class >> overEditableText [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv overEditableText' -> 'Cursor overEditableText'.
	^ Cursor overEditableText
]

{ #category : #accessing }
BlCursor class >> resizeBottom [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottom' -> 'Cursor resizeBottom'.
	^ Cursor resizeBottom
]

{ #category : #accessing }
BlCursor class >> resizeBottomLeft [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottomLeft' -> 'Cursor resizeBottomLeft'.
	^ Cursor resizeBottomLeft
]

{ #category : #accessing }
BlCursor class >> resizeBottomRight [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeBottomRight' -> 'Cursor resizeBottomRight'.
	^ Cursor resizeBottomRight
]

{ #category : #accessing }
BlCursor class >> resizeTop [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTop' -> 'Cursor resizeTop'.
	^ Cursor resizeTop
]

{ #category : #accessing }
BlCursor class >> resizeTopLeft [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTopLeft' -> 'Cursor resizeTopLeft'.
	^ Cursor resizeTopLeft
]

{ #category : #accessing }
BlCursor class >> resizeTopRight [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv resizeTopRight' -> 'Cursor resizeTopRight'.
	^ Cursor resizeTopRight
]

{ #category : #accessing }
BlCursor class >> wait [

	self deprecated: 'Use Cursor instead.' transformWith: '`@rcv wait' -> 'Cursor wait'.
	^ Cursor wait
]
