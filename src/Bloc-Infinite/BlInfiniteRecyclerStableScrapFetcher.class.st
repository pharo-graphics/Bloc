Class {
	#name : #BlInfiniteRecyclerStableScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> attachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController [

	aRecyclerController attachedScrap reverseWithIndexDo: [ :holder :index |
		(holder itemId = anItemId and: [ holder wasReturnedFromScrap not ]) ifTrue: [ 
			anItemType = holder itemType
				ifTrue: [ 
					holder flags addReturnedFromScrap.
					(holder isRemoved and: [ aRecyclerController isPreLayout not ]) ifTrue: [ 
						holder flags
							addUpdate;
							clearInvalid;
							clearRemoved ].
					^ holder ]
				ifFalse: [
					 dryRun ifFalse: [
						aRecyclerController attachedScrap removeAt: index.
						aRecyclerController childRemoved: holder itemElement.
						holder itemElement dispatchRemovedFromParent: holder infiniteElement..
						aRecyclerController quickRecycleScrap: holder itemElement ] ] ] ].
		
	^ nil
]

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> cachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController [

	aRecyclerController cachedScrap reverseWithIndexDo: [ :holder :index |
		holder itemId = anItemId ifTrue: [ 
			(holder itemType = anItemType)
				ifTrue: [ 
					dryRun ifFalse: [ 
						aRecyclerController cachedScrap removeAt: index ].
					^ holder ]
				ifFalse: [ 
					dryRun ifFalse: [ 
						aRecyclerController recycleCachedAt: index ] ] ] ].
	^ nil
]

{ #category : #initialization }
BlInfiniteRecyclerStableScrapFetcher >> defaultNext [
	^ BlInfiniteRecyclerUserCacheFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerStableScrapFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	| offsetPosition holder |
	
	offsetPosition := aRecyclerController computePositionOffset: aPosition.
	
	(offsetPosition < 1 or: [ offsetPosition > aRecyclerController dataSourceItemCount ])
		ifTrue: [ Error signal: 'Wrong item position!' ].
	
	aRecyclerController hasStableIds ifTrue: [ 
		holder := self
			stableScrapForId: (aRecyclerController itemIdAt: offsetPosition)
			type: (aRecyclerController itemTypeAt: offsetPosition)
			dryRun: dryRun
			controller: aRecyclerController.
			
		holder ifNotNil: [ 
			holder position: offsetPosition ] ].
	
	^ holder
		ifNotNil: [ holder -> true ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]
]

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> stableScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController [

	^ (self attachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController)
		ifNil: [ self cachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController ]
]
