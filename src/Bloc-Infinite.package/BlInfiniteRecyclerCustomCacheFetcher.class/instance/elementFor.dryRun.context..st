element fetching
elementFor: aPosition dryRun: dryRun context: aContext
	| holder |
	
	aContext recycler customCache ifNotNil: [ :customCache |
		|element|
		element := customCache
			elementFor: aContext recycler
			at: aPosition
			type: (aContext dataSource itemTypeAt: aPosition).
			
		element ifNotNil: [ :el |
			holder := aContext childHolderOf: el.
			holder ifNil: [ Error signal: 'Returned by custom cache element must have Holder!' ].
			holder shouldIgnore ifTrue: [ Error signal: 'Element can not be in ignore mode! You need to remove #ignore flag first' ] ] ].
	
	^ holder
		ifNotNil: [ holder -> false ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun context: aContext ] ]