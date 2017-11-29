element fetching
elementFor: aPosition dryRun: dryRun controller: aRecyclerController
	| holder fromScrap |
	
	fromScrap := false.
	holder := self positionedScrapFor: aPosition type: BlInfiniteItemType invalid dryRun: dryRun controller: aRecyclerController.
	holder
		ifNotNil: [
			(self validateHolder: holder controller: aRecyclerController)
				ifFalse: [
					dryRun ifFalse: [ 
						holder flags addInvalid.
						holder isScrap
							ifTrue: [ 
								aRecyclerController childRemoved: holder itemElement.
								holder itemElement dispatchRemovedFromParent: holder infiniteElement.
								holder unscrap ]
							ifFalse: [ holder wasReturnedFromScrap
								ifTrue: [ holder clearReturnedFromScrap ] ].
							aRecyclerController recycleElementHolder: holder ].
					holder := nil ]
				ifTrue: [
					fromScrap := true ] ].

	^ holder
		ifNotNil: [ holder -> fromScrap ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]