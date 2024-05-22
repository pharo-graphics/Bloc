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
	#name : #BlInfiniteDataSourceItemRangeChanged,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlInfiniteDataSourceItemRangeChanged >> sendTo: anObject [

	anObject infiniteDataSourceItemRangeChanged: self
]
