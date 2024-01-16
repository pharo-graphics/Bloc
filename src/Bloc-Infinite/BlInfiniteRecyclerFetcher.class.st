Class {
	#name : #BlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #accessing }
BlInfiniteRecyclerFetcher class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> defaultNext [
	^ nil
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> nextFetcher [
	^ self defaultNext 
]
