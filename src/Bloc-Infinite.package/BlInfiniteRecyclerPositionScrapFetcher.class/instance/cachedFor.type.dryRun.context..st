private
cachedFor: aPosition type: itemType dryRun: dryRun context: aContext

	aContext recycler cachedScrap withIndexDo: [ :holder :index |
		(holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ])
			ifTrue: [ 
				dryRun ifFalse: [ aContext recycler cachedScrap removeAt: index ].
				^ holder ] ].
	^ nil