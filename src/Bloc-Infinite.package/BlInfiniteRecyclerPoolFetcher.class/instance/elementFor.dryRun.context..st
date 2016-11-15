element fetching
elementFor: aPosition dryRun: dryRun context: aContext

	| holder |
	holder := aContext recycler pool at: (aContext dataSource itemTypeAt: aPosition).
	holder ifNotNil: #reset.
	
	^ holder
		ifNotNil: [ holder -> false ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun context: aContext ] ]