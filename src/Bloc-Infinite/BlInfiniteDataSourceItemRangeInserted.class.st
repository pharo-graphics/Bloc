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
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlInfiniteDataSourceItemRangeInserted >> sendTo: anObject [

	anObject infiniteDataSourceItemRangeInserted: self
]
