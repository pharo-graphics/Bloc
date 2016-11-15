element fetching
elementFor: aPosition dryRun: dryRun context: aContext
	| holder |

	^ (aContext state isPreLayout and: [ 
		(holder := (self changedScrapFor: aPosition dryRun: dryRun context: aContext)) isNotNil ])
			ifTrue: [ holder -> true ]
			ifFalse: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun context: aContext ] ]