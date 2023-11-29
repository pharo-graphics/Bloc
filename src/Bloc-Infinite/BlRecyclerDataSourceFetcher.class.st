Class {
	#name : 'BlRecyclerDataSourceFetcher',
	#superclass : 'BlInfiniteRecyclerFetcher',
	#category : 'Bloc-Infinite-Recycler',
	#package : 'Bloc-Infinite',
	#tag : 'Recycler'
}

{ #category : 'element fetching' }
BlRecyclerDataSourceFetcher >> elementFor: aPosition in: anInfiniteElement [

	^ anInfiniteElement dataSource createHolder: anInfiniteElement
]
