private
positionedScrapFor: aPosition type: itemType dryRun: dryRun controller: aRecyclerController
	
	(self exactScrapFor: aPosition type: itemType dryRun: dryRun controller: aRecyclerController)
		ifNotNil: [ :holder | ^ holder  ].
	
	dryRun ifFalse: [ 
		(aRecyclerController findHiddenNonRemovedChildAt: aPosition type: itemType)
			ifNotNil: [ :child |
				aRecyclerController endAnimation: (aRecyclerController childHolderOf: child) ] ].
		
	^ self cachedFor: aPosition type: itemType dryRun: dryRun controller: aRecyclerController