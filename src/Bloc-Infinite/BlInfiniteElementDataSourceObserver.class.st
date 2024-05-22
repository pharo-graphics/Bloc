"
I am a data source observer registered by infinite element to support internal synchronisation of data and its representation.


"
Class {
	#name : #BlInfiniteElementDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'infiniteElement'
	],
	#category : #'Bloc-Infinite-DataSource'
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

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceChanged: anEvent [


	self assertNotInLayoutOrScroll.
	infiniteElement setDataSourceChangedAfterLayout.
	infiniteElement dataSourceManager hasPendingCommands
		ifFalse: [ infiniteElement requestLayout ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [	

	self assertNotInLayoutOrScroll.

	infiniteElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [
	self assertNotInLayoutOrScroll.
	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (infiniteElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ]
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #'event handling' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #initialization }
BlInfiniteElementDataSourceObserver >> initializeWith: anInfiniteElement [
	
	self
		assert: [ infiniteElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	infiniteElement := anInfiniteElement
]

{ #category : #private }
BlInfiniteElementDataSourceObserver >> triggerUpdateProcessor [

	infiniteElement markDataSourceChangeDuringMeasure.
	infiniteElement requestLayout
]
