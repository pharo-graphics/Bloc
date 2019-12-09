"
I am an abstract listener associated with a specific resizer element (e.g., bottom right). My subclasses define the specific behavior.

An element with applied Resizer Listener sends ==BlResizerResizedEvent== after the resizing target was resized
"
Class {
	#name : #BlResizerListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'dragStartPosition',
		'originalPosition',
		'resizeTarget',
		'originalExtent',
		'minimumExtent'
	],
	#category : #'Bloc-Utilities - Resizable'
}

{ #category : #'dnd handlers' }
BlResizerListener >> dragEndEvent: anEvent [
	anEvent consumed: true
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragEvent: anEvent [
	<event: #BlResizerResizedEvent>
	| dragPosition dragDelta theBounds theOriginalBounds widthChanged heightChanged |

	anEvent consumed: true.
	
	self hasTarget
		ifFalse: [ ^ self ].

	dragPosition := anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	theBounds := BlBounds origin: originalPosition extent: originalExtent.
	theOriginalBounds := theBounds copy.

	self
		resizeBounds: theBounds
		by: dragDelta.
	
	widthChanged := theBounds width ~= theOriginalBounds width.
	heightChanged := theBounds height ~= theOriginalBounds height.
	
	self resizeTarget globalBoundsToLocal: theBounds.
	self resizeTarget localBoundsToParent: theBounds.

	self resizeTarget relocate: theBounds position.
	
	(widthChanged or: [ heightChanged ])
		ifFalse: [ ^ self ].

	widthChanged
		ifTrue: [ self resizeTarget width: theBounds width ].

	heightChanged
		ifTrue: [ self resizeTarget height: theBounds height ].
	
	self resizeTarget dispatchEvent: (BlResizerResizedEvent new extent: theBounds extent).
	anEvent currentTarget dispatchEvent: (BlResizerResizedEvent new extent: theBounds extent)
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent position.

	self hasTarget
		ifFalse: [ ^ self ].

	"element's original extent"
	originalExtent := self resizeTarget bounds inSpace extent.
	originalPosition := self resizeTarget bounds inSpace position
]

{ #category : #testing }
BlResizerListener >> hasTarget [
	^ resizeTarget isNotNil
]

{ #category : #initialization }
BlResizerListener >> initialize [
	super initialize.

	minimumExtent := 5 asPoint
]

{ #category : #resizer }
BlResizerListener >> minimumExtent [
	<return: #Point>

	^ minimumExtent
]

{ #category : #resizer }
BlResizerListener >> minimumExtent: aPoint [
	minimumExtent := aPoint
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseDownEvent: anEvent [
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseEnterEvent: anEvent [
	anEvent currentTarget mouseCursor: self resizerCursor
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseLeaveEvent: anEvent [
	anEvent currentTarget mouseCursor: nil
]

{ #category : #resizer }
BlResizerListener >> resizeBounds: aBlBounds by: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
BlResizerListener >> resizeTarget [
	^ resizeTarget
]

{ #category : #accessing }
BlResizerListener >> resizeTarget: anObject [
	resizeTarget := anObject
]

{ #category : #resizer }
BlResizerListener >> resizeTargetBy: aDelta [
	(aDelta isZero not)
		ifTrue: [ ^ self resizeTarget size: aDelta ].

	aDelta x isZero
		ifTrue: [ ^ self resizeTarget width: aDelta x ].
		
	aDelta y isZero
		ifTrue: [ ^ self resizeTarget height: aDelta x isZero ]
]

{ #category : #resizer }
BlResizerListener >> resizerCursor [
	<return: #Form>

	^ self subclassResponsibility
]
