element fetching
elementFor: aPosition dryRun: dryRun controller: aRecyclerController
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