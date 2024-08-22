Extension { #name : #BlSpaceEventListener }

{ #category : #'*BookletGraphicsBloc' }
BlSpaceEventListener >> spaceDragCancelEvent: anEvent [
	| aDragDelegate |
	self space removeEventHandler: mouseDragListener.

	dragContainerElement ifNil: [ ^ self ].

	aDragDelegate := dragContainerElement userData at: #dragDelegate.
	
	aDragDelegate
		cancel: dragContainerElement
		at: anEvent position
		in: self space root.

	dragContainerElement ifNotNil: [ :anElement | anElement removeFromParent ].
	dragContainerElement := nil.
]

{ #category : #'*BookletGraphicsBloc' }
BlSpaceEventListener >> spaceDragDraggedEvent: anEvent [
	| aDropDelegate aDragDelegate aPosition |

	aDropDelegate := anEvent delegate.
	aPosition := anEvent position.

	dragContainerElement ifNil: [ ^ self ].

	aDragDelegate := dragContainerElement userData at: #dragDelegate.
	aDropDelegate
		dragged: dragContainerElement
		items: aDragDelegate items
		at: aPosition
		offset: aDragDelegate offset
		in: anEvent element
]

{ #category : #'*BookletGraphicsBloc' }
BlSpaceEventListener >> spaceDragDropEnterEvent: anEvent [
	| aDropDelegate aDragDelegate aPosition |
	
	anEvent consumed: true.

	aDropDelegate := anEvent delegate.
	aPosition := anEvent position.

	dragContainerElement ifNil: [ ^ self ].

	aDragDelegate := dragContainerElement userData at: #dragDelegate.
	aDropDelegate
		enter: aDragDelegate items
		at: aPosition
		in: anEvent element
]

{ #category : #'*BookletGraphicsBloc' }
BlSpaceEventListener >> spaceDragDropEvent: anEvent [
	| aDropDelegate aDragDelegate aPosition theRejectedItems|

	aDropDelegate := anEvent delegate.
	aPosition := anEvent position.

	dragContainerElement ifNil: [ ^ self ].

	aDragDelegate := dragContainerElement userData at: #dragDelegate.

	theRejectedItems := aDropDelegate
		drop: aDragDelegate items
		at: aPosition
		in: anEvent element.
	aDragDelegate items: theRejectedItems
]

{ #category : #'*BookletGraphicsBloc' }
BlSpaceEventListener >> spaceDragLiftEvent: anEvent [
	| aDragDelegate aPosition aDragArea |

	aDragDelegate := anEvent delegate.
	aPosition := anEvent position.
	
	dragContainerElement ifNotNil: [ :anElement | anElement removeFromParent ].
	dragContainerElement := aDragDelegate liftAt: aPosition.
	dragContainerElement userData at: #dragDelegate put: aDragDelegate.
	dragContainerElement preventMeAndChildrenMouseEvents.
	
	aDragDelegate
		drag: dragContainerElement
		to: (dragContainerElement globalPointToParent: aPosition).

	aDragArea := aDragDelegate hasDragArea
		ifTrue: [ aDragDelegate dragArea ]
		ifFalse: [ self space root ].

	aDragArea addChild: dragContainerElement.

	mouseDragListener := BlEventHandler
		on: BlMouseMoveEvent
		do: [ :aMouseMoveEvent |
			aDragDelegate
				drag: dragContainerElement
				to: (dragContainerElement globalPointToParent: aMouseMoveEvent position) ].

	self space addEventHandler: mouseDragListener
]
