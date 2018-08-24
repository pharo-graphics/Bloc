"
Sent when an item reflected at ===from=== position has been moved to ===to=== position.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- BlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: BlInfiniteDataSourceItemRangeMoved
	do: [ :event | self inform: 'Item was moved from: ', event from asString, ' to: ', event to asString ]
"
Class {
	#name : #BlInfiniteDataSourceItemRangeMoved,
	#superclass : #BlInfiniteDataSourceEvent,
	#instVars : [
		'from',
		'to'
	],
	#category : 'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteDataSourceItemRangeMoved class >> from: aFromPosition to: aToPosition [
	^ self new
		from: aFromPosition;
		to: aToPosition;
		yourself
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeMoved >> from [
	^ from
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeMoved >> from: anObject [
	from := anObject
]

{ #category : #sending }
BlInfiniteDataSourceItemRangeMoved >> sendTo: anObject [
	anObject onItemsMoved: self
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeMoved >> to [
	^ to
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeMoved >> to: anObject [
	to := anObject
]
