Class {
	#name : #BlInfiniteDataSourceItemRangeEvent,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#instVars : [
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

{ #category : #sending }
BlInfiniteDataSourceItemRangeEvent >> sendTo: anObject [

	anObject infiniteDataSourceItemRangeEvent: self
]
