"
This class is the beginning of a prototype
"
Class {
	#name : #BlDragHandlerNew,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'liftItemBlock',
		'dragAreaBlock',
		'dragDelegate',
		'dragStartPosition'
	],
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'dnd handlers' }
BlDragHandlerNew >> createDragItemFor: aSourceElement [

	^ liftItemBlock
		ifNil: [
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: nil ]
		ifNotNil: [ :aBlock | aBlock cull: aSourceElement ]
]

{ #category : #accessing }
BlDragHandlerNew >> dragArea: aBlock [
	dragAreaBlock := aBlock
]

{ #category : #accessing }
BlDragHandlerNew >> dragDelegate [ 

	^ dragDelegate 
]

{ #category : #'dnd handlers' }
BlDragHandlerNew >> dragStartEvent: anEvent [

	anEvent consumed: true. 
	dragStartPosition := anEvent currentTarget position.

	dragDelegate items:
		{ (self createDragItemFor: anEvent currentTarget) }.
	dragDelegate offset: anEvent localPosition.
	dragDelegate parent: anEvent currentTarget parent.

	dragAreaBlock ifNotNil: [ :aBlock |
		dragDelegate dragArea: (aBlock value: anEvent currentTarget) ].

	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new
			 delegate: dragDelegate;
			 position: anEvent position)
]

{ #category : #accessing }
BlDragHandlerNew >> dragStrategy [

	^ dragDelegate dragStrategy
]

{ #category : #accessing }
BlDragHandlerNew >> dragStrategy: aBlDragStrategy [

	dragDelegate dragStrategy: aBlDragStrategy 
]

{ #category : #'api - accessing' }
BlDragHandlerNew >> eventsToHandle [
	^ { BlDragStartEvent }
]

{ #category : #initialization }
BlDragHandlerNew >> initialize [

	super initialize.
	dragDelegate := BlDragDelegateNew new.
]

{ #category : #accessing }
BlDragHandlerNew >> liftItemBlock: aBlock [
	liftItemBlock := aBlock
]
