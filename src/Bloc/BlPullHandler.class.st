"
I add an ability to drag (pull) any arbitrary element within its direct parent by requesting position change.
Note, that some layout do not allow elements to have custom positions which means I have no effect.

Example:

[[[
| element |		

element := BlElement new.
element background: Color red.
element size: 75@75.
element addEventHandler: BlPullHandler new.	
]]]
"
Class {
	#name : #BlPullHandler,
	#superclass : #BlElementEventListener,
	#instVars : [
		'originalPosition',
		'dragStartPosition',
		'allowedOutOfBounds'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'as yet unclassified' }
BlPullHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #'as yet unclassified' }
BlPullHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'dnd handlers' }
BlPullHandler >> dragEndEvent: anEvent [
	anEvent consumed: true
]

{ #category : #'dnd handlers' }
BlPullHandler >> dragEvent: anEvent [
	| dragPosition dragDelta aNewPosition |

	dragPosition := anEvent currentTarget globalPointToParent: anEvent position.
	dragDelta := dragPosition - (dragStartPosition ifNil: [ dragStartPosition := dragPosition ]).
	
	aNewPosition := ((originalPosition ifNil: [ originalPosition := anEvent currentTarget position ]) + dragDelta).
	
	allowedOutOfBounds ifFalse: [
		| aMaxPosition |
		
		aMaxPosition := (anEvent currentTarget hasParent
			ifTrue: [ anEvent currentTarget parent extent - anEvent currentTarget extent ]
			ifFalse: [ 0@0 ]).		
		aNewPosition := aNewPosition min: aMaxPosition max: 0@0 ].

	anEvent currentTarget relocate: aNewPosition.
	anEvent consumed: true
]

{ #category : #'dnd handlers' }
BlPullHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent currentTarget globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := anEvent currentTarget position.

]

{ #category : #initialization }
BlPullHandler >> initialize [
	super initialize.
	
	allowedOutOfBounds := true
]
