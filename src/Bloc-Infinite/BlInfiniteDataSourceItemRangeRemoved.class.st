"
Sent when the ===itemCount=== items previously located at ===position=== have been removed from the data set.
The items previously located at and after ===position + itemCount + 1=== may now be found ===oldPosition - itemCount===.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- BlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: BlInfiniteDataSourceItemRangeRemoved
	do: [ :event | self inform: event itemCount asString, ' items were removed starting from: ', event position asString ]
"
Class {
	#name : #BlInfiniteDataSourceItemRangeRemoved,
	#superclass : #BlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount'
	],
	#category : 'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteDataSourceItemRangeRemoved class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeRemoved >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeRemoved >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeRemoved >> position [
	^ position
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeRemoved >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlInfiniteDataSourceItemRangeRemoved >> sendTo: anObject [
	anObject onItemsRemoved: self
]
