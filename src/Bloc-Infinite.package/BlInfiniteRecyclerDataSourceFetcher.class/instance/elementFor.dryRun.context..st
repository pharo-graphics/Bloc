element fetching
elementFor: aPosition dryRun: dryRun context: aContext

	| holder |
	holder := aContext dataSource
		createHolder: aContext
		type: (aContext dataSource itemTypeAt: aPosition).
		
	holder ifNil: [ Error signal: 'Data source must not return nil golder!' ].
	
	^ holder -> false