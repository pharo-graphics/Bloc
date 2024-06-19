Class {
	#name : #BlInfiniteScrollFlinger,
	#superclass : #BlScrollFlinger,
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Scroller'
}

{ #category : #'instance creation' }
BlInfiniteScrollFlinger class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onFinished [
	self scrollable prefetchingAllowed
		ifTrue: [ self shouldBeImplemented ]
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onInitialized [
	self scrollable onEnterLayoutOrScroll
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onLayoutScrolled [

	self scrollable onExitLayoutOrScroll
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onNotFinished [
	self scrollable prefetchingAllowed
		ifTrue: [ self shouldBeImplemented ]
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onPrepareToRun [

	self scrollable consumePendingDataSourceCommands
]
