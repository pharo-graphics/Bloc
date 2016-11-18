private
idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController

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
					holder flagReturnedFromScrap: true.
					^ holder ] ] ].
	^ nil