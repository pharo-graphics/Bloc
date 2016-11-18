private
cachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController

	aRecyclerController cachedScrap reverseWithIndexDo: [ :holder :index |
		holder itemId = anItemId ifTrue: [ 
			(holder itemType = anItemType)
				ifTrue: [ 
					dryRun ifFalse: [ 
						aRecyclerController cachedScrap removeAt: index ].
					^ holder ]
				ifFalse: [ 
					dryRun ifFalse: [ 
						aRecyclerController recycleCachedAt: index ] ] ] ].
	^ nil