Class {
	#name : #BlDropDelegate,
	#superclass : #Object,
	#instVars : [
		'acceptConditions'
	],
	#category : #'Bloc-DragNDrop-core'
}

{ #category : #accessing }
BlDropDelegate >> acceptConditions [

	^ acceptConditions
]

{ #category : #accessing }
BlDropDelegate >> acceptConditions: aCollectionOfBlockClosures [

	acceptConditions := aCollectionOfBlockClosures
]

{ #category : #'drag and drop' }
BlDropDelegate >> dragged: aDragContainerElement items: aCollectionOfDragItems at: aPosition offset: anOffset in: anElement [

	| doesAccept |
	doesAccept := aCollectionOfDragItems anySatisfy: [ :eachDragItem |self shouldAccept: eachDragItem in: anElement ].
	doesAccept ifFalse: [ ^ self ].
	
	anElement dispatchEvent: (BlItemsDraggedEvent new
			 dragContainer: aDragContainerElement;
			 items: aCollectionOfDragItems;
			 position: (anElement globalPointToLocal: aPosition);
			 offset: anOffset)
]

{ #category : #'drag and drop' }
BlDropDelegate >> drop: aCollectionOfDragItems at: aPosition in: anElement [

	| rejectedItems acceptedItems |
	rejectedItems := OrderedCollection new.
	acceptedItems := OrderedCollection new.

	aCollectionOfDragItems do: [ :eachDragItem |
		(self shouldAccept: eachDragItem in: anElement)
			ifTrue: [ acceptedItems add: eachDragItem ]
			ifFalse: [ rejectedItems add: eachDragItem ] ].

	acceptedItems do: [ :eachDragItem |
		eachDragItem sourceElement dispatchEvent:
			(BlAboutToBeDroppedEvent new dropTarget: anElement) ].

	"didn't include element state in my code picking"
	"acceptedItems do: [ :each |
		each sourceElement states
			removeState: BlElementDraggingState uniqueInstance ]."

	anElement dispatchEvent: (BlItemsDroppedEvent new
			 items: acceptedItems;
			 position: (anElement globalPointToLocal: aPosition)).

	^ rejectedItems asArray
]

{ #category : #'drag and drop' }
BlDropDelegate >> enter: aCollectionOfDragItems at: aPosition in: anElement [

	| doesAccept |
	doesAccept := aCollectionOfDragItems anySatisfy: [ :eachDragItem | self shouldAccept: eachDragItem in: anElement ]
]

{ #category : #asserting }
BlDropDelegate >> shouldAccept: aDragItem in: anElement [

	^ acceptConditions allSatisfy: [ :eachCondition | eachCondition cull: aDragItem cull: anElement ]
]
