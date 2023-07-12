"
Sent when currently reflected `=itemCount`= items starting at `=position`= have been newly inserted.
The items previously located at `=position`= and beyond can now be found starting at position `=position + itemCount`=.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeInserted
	do: [ :event | self inform: event itemCount asString, ' items were inserted at: ', event position asString ]

"
Class {
	#name : #BlInfiniteDataSourceItemRangeInserted,
	#superclass : #BlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteDataSourceItemRangeInserted class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeInserted >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeInserted >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeInserted >> position [
	^ position
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeInserted >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlInfiniteDataSourceItemRangeInserted >> sendTo: anObject [
	anObject onItemsInserted: self
]
