"
I am a data source observer registered by infinite element to support internal synchronisation of data and its representation.
"
Class {
	#name : #BlInfiniteElementDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'infiniteElement'
	],
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #'instance creation' }
BlInfiniteElementDataSourceObserver class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #private }
BlInfiniteElementDataSourceObserver >> assertNotInLayoutOrScroll [
	infiniteElement assertNotInLayoutOrScroll
]

{ #category : #initialization }
BlInfiniteElementDataSourceObserver >> initializeWith: anInfiniteElement [
	
	self
		assert: [ infiniteElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	infiniteElement := anInfiniteElement
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onChanged: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement state structureChanged: true.
	infiniteElement setDataSourceChangedAfterLayout.

	infiniteElement dataSourceManager hasPendingCommands
		ifFalse: [ infiniteElement requestLayout ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onItemsChanged: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.

	needsUpdate := infiniteElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
		payload: anEvent payload.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onItemsEvent: anEvent [
	self assertNotInLayoutOrScroll.

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (infiniteElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onItemsInserted: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onItemsMoved: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeMoved: anEvent from
		to: anEvent to
		itemCount: 1.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> onItemsRemoved: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #private }
BlInfiniteElementDataSourceObserver >> triggerUpdateProcessor [
	(infiniteElement hasFixedSize and: [ infiniteElement isAttached ])
		ifTrue: [ infiniteElement postChildrenUpdater ]
		ifFalse: [
			infiniteElement markDataSourceChangeDuringMeasure.
			infiniteElement requestLayout ]
]
