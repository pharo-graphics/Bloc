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
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'originalPosition',
		'dragStartPosition',
		'allowedOutOfBounds',
		'direction'
	],
	#classVars : [
		'Any',
		'Horizontal',
		'Vertical'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'class initialization' }
BlPullHandler class >> initialize [	
	Any := #any.
	Vertical := #vertical.
	Horizontal := #horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #'api - pull handler' }
BlPullHandler >> beFree [
	direction := Any
]

{ #category : #'api - pull handler' }
BlPullHandler >> beHorizontal [
	direction := Horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> beVertical [
	direction := Vertical
]

{ #category : #'private - pulling' }
BlPullHandler >> computePullDelta: aDragDelta [
	<return: #Number>
	
	direction = Any
		ifTrue: [ ^ aDragDelta ].
		
	direction = Vertical
		ifTrue: [ ^ 0 @ aDragDelta y ].
		
	direction = Horizontal
		ifTrue: [ ^ aDragDelta x @ 0 ].
		
	^ direction
]

{ #category : #'api - pull handler' }
BlPullHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'event handling' }
BlPullHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	
	anEvent currentTarget dispatchEvent: BlPullEndEvent new
]

{ #category : #'event handling' }
BlPullHandler >> dragEvent: anEvent [
	| dragPosition dragDelta aNewPosition |

	dragPosition := anEvent currentTarget globalPointToParent: anEvent position.
	dragDelta := dragPosition - (dragStartPosition ifNil: [ dragStartPosition := dragPosition ]).
	
	dragDelta := self computePullDelta: dragDelta.
	
	aNewPosition := ((originalPosition ifNil: [ originalPosition := anEvent currentTarget position ]) + dragDelta).
	
	allowedOutOfBounds ifFalse: [
		| aMaxPosition |

		aMaxPosition := (anEvent currentTarget hasParent
			ifTrue: [ anEvent currentTarget parent extent - anEvent currentTarget extent ]
			ifFalse: [ 0@0 ]).
		aNewPosition := aNewPosition min: aMaxPosition max: 0@0 ].

	anEvent currentTarget relocate: aNewPosition.
	anEvent consumed: true.

	anEvent currentTarget dispatchEvent: (BlPullEvent new
		oldPosition: dragPosition;
		newPosition: aNewPosition;
		delta: dragDelta)
]

{ #category : #'event handling' }
BlPullHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent currentTarget globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := anEvent currentTarget position.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #'api - accessing' }
BlPullHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #initialization }
BlPullHandler >> initialize [
	super initialize.
	
	allowedOutOfBounds := true.
	direction := Any
]
