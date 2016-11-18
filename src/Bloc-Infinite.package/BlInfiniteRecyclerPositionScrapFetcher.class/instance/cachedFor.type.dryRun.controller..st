private
cachedFor: aPosition type: itemType dryRun: dryRun controller: aRecyclerController

	aRecyclerController cachedScrap withIndexDo: [ :holder :index |
		(holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ])
			ifTrue: [ 
				dryRun ifFalse: [ aRecyclerController cachedScrap removeAt: index ].
				^ holder ] ].
	^ nil