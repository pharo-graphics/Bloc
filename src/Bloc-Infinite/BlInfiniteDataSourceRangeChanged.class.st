Class {
	#name : #BlInfiniteDataSourceRangeChanged,
	#superclass : #BlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteDataSourceRangeChanged class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #accessing }
BlInfiniteDataSourceRangeChanged >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceRangeChanged >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceRangeChanged >> position [
	^ position
]

{ #category : #accessing }
BlInfiniteDataSourceRangeChanged >> position: anObject [
	position := anObject
]
