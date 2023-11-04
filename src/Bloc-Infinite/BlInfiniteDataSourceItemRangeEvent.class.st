Class {
	#name : #BlInfiniteDataSourceItemRangeEvent,
	#superclass : #BlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount',
		'event'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> event [
	^ event
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> event: anObject [
	event := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> position [
	^ position
]

{ #category : #accessing }
BlInfiniteDataSourceItemRangeEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlInfiniteDataSourceItemRangeEvent >> sendTo: anObject [
	anObject onItemsEvent: self
]
