element fetching
elementFor: aPosition dryRun: dryRun controller: aRecyclerController
	| holder |

	^ (aRecyclerController isPreLayout and: [ 
		(holder := (self changedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController)) isNotNil ])
			ifTrue: [ holder -> true ]
			ifFalse: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ]