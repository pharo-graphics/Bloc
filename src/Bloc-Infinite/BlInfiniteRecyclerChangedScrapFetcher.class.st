Class {
	#name : #BlInfiniteRecyclerChangedScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #private }
BlInfiniteRecyclerChangedScrapFetcher >> changedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [

	(aRecyclerController hasChangedScrap)
		ifFalse: [ ^ nil ].
	
	^ (self positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController)
		ifNil: [ self idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController ]
]

{ #category : #initialization }
BlInfiniteRecyclerChangedScrapFetcher >> defaultNext [
	^ BlInfiniteRecyclerPositionScrapFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerChangedScrapFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	| holder |

	^ (aRecyclerController isPreLayout and: [ 
		(holder := (self changedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController)) isNotNil ])
			ifTrue: [ holder -> true ]
			ifFalse: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]
]

{ #category : #private }
BlInfiniteRecyclerChangedScrapFetcher >> idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [

	aRecyclerController hasStableIds ifTrue: [
		| offsetPosition |
		offsetPosition := aRecyclerController computePositionOffset: aPosition.
		(offsetPosition > 1 and: [ offsetPosition <= aRecyclerController dataSourceItemCount ]) ifTrue: [ 
			|id|
			id := aRecyclerController itemIdAt: offsetPosition.
			aRecyclerController changedScrap
				detect: [ :holder |
					holder wasReturnedFromScrap not and: [ holder itemId = id ] ]
				ifFound: [ :holder |
					holder flags addReturnedFromScrap.
					^ holder ] ] ].
	^ nil
]

{ #category : #private }
BlInfiniteRecyclerChangedScrapFetcher >> positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [

	^ aRecyclerController changedScrap
		detect: [ :holder |
			holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ] ]
		ifFound: [ :holder |
			holder flags addReturnedFromScrap.
			holder ]
		ifNone: [ nil ]
]
