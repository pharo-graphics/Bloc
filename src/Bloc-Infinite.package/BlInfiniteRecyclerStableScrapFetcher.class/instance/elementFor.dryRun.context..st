element fetching
elementFor: aPosition dryRun: dryRun context: aContext
	| offsetPosition holder |
	
	offsetPosition := aContext dataSourceController computePositionOffset: aPosition.
	
	(offsetPosition < 1 or: [ offsetPosition > aContext dataSource itemCount ])
		ifTrue: [ Error signal: 'Wrong item position!' ].
	
	aContext dataSource hasStableIds ifTrue: [ 
		holder := self
			stableScrapForId: (aContext dataSource itemIdAt: offsetPosition)
			type: (aContext dataSource itemTypeAt: offsetPosition)
			dryRun: dryRun
			context: aContext.
			
		holder ifNotNil: [ 
			holder position: offsetPosition ] ].
	
	^ holder
		ifNotNil: [ holder -> true ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun context: aContext ] ]