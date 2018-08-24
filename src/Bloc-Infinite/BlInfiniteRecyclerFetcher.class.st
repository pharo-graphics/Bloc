Class {
	#name : #BlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#instVars : [
		'nextFetcher'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #cleanup }
BlInfiniteRecyclerFetcher class >> cleanUp [
	super cleanUp.
	
	instance := nil
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> defaultNext [
	^ self subclassResponsibility
]

{ #category : #'element fetching' }
BlInfiniteRecyclerFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> initialize [
	super initialize.
	
	nextFetcher := self defaultNext
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> next [
	^ nextFetcher
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> next: aRecyclerFetcher [
	nextFetcher := aRecyclerFetcher
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> nextDo: aBlock [
	^ self next ifNotNil: aBlock
]
