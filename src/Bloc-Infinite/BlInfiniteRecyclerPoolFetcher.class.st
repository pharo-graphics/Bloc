Class {
	#name : #BlInfiniteRecyclerPoolFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerPoolFetcher >> defaultNext [
	^ BlInfiniteRecyclerDataSourceFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerPoolFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	^ aRecyclerController infiniteElement telemetry
		timeSync: [ 'Fetch element from pool at {1}' format: { aPosition } ]
		during: [
			| holder |
			holder := aRecyclerController recyclerPool at: (aRecyclerController itemTypeAt: aPosition).
			holder ifNotNil: #reset.

			holder
				ifNotNil: [ holder -> false ]
				ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ] ]
]
