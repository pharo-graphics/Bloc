"
Sent when the data set has changed.
There are two different classes of data change events, item changes and structural changes. Item changes are when a single item has its data updated but no positional changes have occurred. Structural changes are when items are inserted, removed or moved within the data set.
This event does not specify what about the data set has changed, forcing any observers to assume that all existing items and structure may no longer be valid.
InfiniteLayout will be forced to fully rebind and relayout all visible elements.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceChanged
	do: [ self inform: 'Data source changed!' ]

"
Class {
	#name : #BlInfiniteDataSourceChanged,
	#superclass : #BlInfiniteDataSourceEvent,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlInfiniteDataSourceChanged >> sendTo: anObject [

	anObject infiniteDataSourceChanged: self
]
