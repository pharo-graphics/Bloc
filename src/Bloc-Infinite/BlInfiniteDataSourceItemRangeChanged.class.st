"
Sent when the `=itemCount`= items starting at `=position`= have changed.
This is an item change event, not a structural change event. It indicates that any reflection of the data in the given position range is out of date and should be updated. The items in the given range retain the same identity.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeChanged
	do: [ :event | self inform: event itemCount asString, ' items were changed starting from: ', event position asString ]

"
Class {
	#name : 'BlInfiniteDataSourceItemRangeChanged',
	#superclass : 'BlInfiniteDataSourceEvent',
	#instVars : [
		'position',
		'itemCount'
	],
	#category : 'Bloc-Infinite-Events',
	#package : 'Bloc-Infinite',
	#tag : 'Events'
}

{ #category : 'instance creation' }
BlInfiniteDataSourceItemRangeChanged class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : 'accessing' }
BlInfiniteDataSourceItemRangeChanged >> itemCount [
	^ itemCount
]

{ #category : 'accessing' }
BlInfiniteDataSourceItemRangeChanged >> itemCount: anObject [
	itemCount := anObject
]

{ #category : 'accessing' }
BlInfiniteDataSourceItemRangeChanged >> position [
	^ position
]

{ #category : 'accessing' }
BlInfiniteDataSourceItemRangeChanged >> position: anObject [
	position := anObject
]

{ #category : 'sending' }
BlInfiniteDataSourceItemRangeChanged >> sendTo: anObject [
	anObject onItemsChanged: self
]
