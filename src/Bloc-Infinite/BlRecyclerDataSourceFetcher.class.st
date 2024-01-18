Class {
	#name : #BlRecyclerDataSourceFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
BlRecyclerDataSourceFetcher >> elementFor: aPosition in: anInfiniteElement [

	^ anInfiniteElement dataSource createHolder: anInfiniteElement
]
