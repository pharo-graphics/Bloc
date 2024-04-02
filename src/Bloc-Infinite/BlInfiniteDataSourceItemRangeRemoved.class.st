"
Sent when the `=itemCount`= items previously located at `=position`= have been removed from the data set.
The items previously located at and after `=position + itemCount + 1`= may now be found `=oldPosition - itemCount`=.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeRemoved
	do: [ :event | self inform: event itemCount asString, ' items were removed starting from: ', event position asString ]

"
Class {
	#name : #BlInfiniteDataSourceItemRangeRemoved,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlInfiniteDataSourceItemRangeRemoved >> sendTo: anObject [

	anObject infiniteDataSourceItemRangeRemoved: self
]
