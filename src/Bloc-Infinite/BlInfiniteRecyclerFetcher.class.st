Class {
	#name : #BlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
BlInfiniteRecyclerFetcher >> elementFor: aPosition in: anInfiniteElement [

	^ self subclassResponsibility 
]
