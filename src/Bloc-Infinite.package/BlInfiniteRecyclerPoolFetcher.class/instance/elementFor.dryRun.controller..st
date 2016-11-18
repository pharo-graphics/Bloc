element fetching
elementFor: aPosition dryRun: dryRun controller: aRecyclerController

	| holder |
	holder := aRecyclerController recyclerPool at: (aRecyclerController itemTypeAt: aPosition).
	holder ifNotNil: #reset.

	^ holder
		ifNotNil: [ holder -> false ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]