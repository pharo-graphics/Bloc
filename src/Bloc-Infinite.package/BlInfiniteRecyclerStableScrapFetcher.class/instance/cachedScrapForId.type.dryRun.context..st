private
cachedScrapForId: anItemId type: anItemType dryRun: dryRun context: aContext

	aContext recycler cachedScrap reverseWithIndexDo: [ :holder :index |
		holder itemId = anItemId ifTrue: [ 
			(holder itemType = anItemType)
				ifTrue: [ 
					dryRun ifFalse: [ 
						aContext recycler cachedScrap removeAt: index ].
					^ holder ]
				ifFalse: [ 
					dryRun ifFalse: [ 
						aContext recycler recycleCachedAt: index ] ] ] ].
	^ nil