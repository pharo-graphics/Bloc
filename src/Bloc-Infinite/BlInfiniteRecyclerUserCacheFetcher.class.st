Class {
	#name : #BlInfiniteRecyclerUserCacheFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerUserCacheFetcher >> defaultNext [
	^ BlInfiniteRecyclerPoolFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerUserCacheFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	| holder |

	aRecyclerController userCache ifNotNil: [ :customCache |
		|element|

		element := customCache
			elementFor: aRecyclerController recycler
			at: aPosition
			type: (aRecyclerController itemTypeAt: aPosition).

		element ifNotNil: [ :el |
			holder := aRecyclerController elementHolderOf: el.
			holder ifNil: [ Error signal: 'Returned by custom cache element must have Holder!' ].
			holder shouldIgnore ifTrue: [ Error signal: 'Element can not be in ignore mode! You need to remove #ignore flag first' ] ] ].

	^ holder
		ifNotNil: [ holder -> false ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]
]
