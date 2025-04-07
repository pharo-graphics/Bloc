"
specify behavior on how to handle the event to drag an element
Current event being managed:
- BlDragStartEvent
Real behavior is delegated to `BlDragDelegate`
"
Class {
	#name : #BlDragHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'liftItemBlock',
		'dragAreaBlock'
	],
	#category : #'Bloc-DragNDrop-core'
}

{ #category : #'dnd handlers' }
BlDragHandler >> createDragItemFor: aSourceElement [
	<return: #BlDragItem>

	^ liftItemBlock
		ifNil: [
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: nil ]
		ifNotNil: [ :aBlock | aBlock cull: aSourceElement ]
]

{ #category : #accessing }
BlDragHandler >> dragArea: aBlock [
	dragAreaBlock := aBlock
]

{ #category : #'dnd handlers' }
BlDragHandler >> dragStartEvent: anEvent [
	| aDragDelegate |

	anEvent consumed: true.

	aDragDelegate := BlDragDelegate new.
	aDragDelegate items: { self createDragItemFor: anEvent currentTarget }.
	aDragDelegate offset: anEvent localPosition.
	aDragDelegate parent: anEvent currentTarget parent.

	dragAreaBlock
		ifNotNil: [ :aBlock |
			aDragDelegate dragArea: (aBlock value: anEvent currentTarget) ].

	anEvent currentTarget space
		dispatchEvent: (BlSpaceDragLiftEvent new
			delegate: aDragDelegate;
			position: anEvent position)
]

{ #category : #'api - accessing' }
BlDragHandler >> eventsToHandle [
	^ { BlDragStartEvent }
]

{ #category : #accessing }
BlDragHandler >> liftItemBlock: aBlock [
	liftItemBlock := aBlock
]
