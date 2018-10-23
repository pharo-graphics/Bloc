Class {
	#name : #BlCursorStencil,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlCursorStencil class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlCursorStencil class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - instantiation' }
BlCursorStencil >> asElement [
	^ self create
]

{ #category : #'api - instantiation' }
BlCursorStencil >> asStencil [
	^ self
]

{ #category : #'api - instantiation' }
BlCursorStencil >> create [
	^ BlCursorElement new
		constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent ];
		background: Color black
]
