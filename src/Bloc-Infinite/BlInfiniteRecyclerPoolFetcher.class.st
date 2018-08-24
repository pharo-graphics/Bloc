Class {
	#name : #BlInfiniteRecyclerPoolFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerPoolFetcher >> defaultNext [
	^ BlInfiniteRecyclerDataSourceFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerPoolFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [

	| holder |
	holder := aRecyclerController recyclerPool at: (aRecyclerController itemTypeAt: aPosition).
	holder ifNotNil: #reset.

	^ holder
		ifNotNil: [ holder -> false ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]
]
