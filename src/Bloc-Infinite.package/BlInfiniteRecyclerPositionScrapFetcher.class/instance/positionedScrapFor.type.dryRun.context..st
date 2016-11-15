private
positionedScrapFor: aPosition type: itemType dryRun: dryRun context: aContext
	
	(self exactScrapFor: aPosition type: itemType dryRun: dryRun context: aContext)
		ifNotNil: [ :holder | ^ holder  ].
	
	dryRun ifFalse: [ 
		(aContext childrenController findHiddenNonRemovedChildAt: aPosition type: itemType)
			ifNotNil: [ :child |
				aContext itemAnimator endAnimation: (aContext childHolderOf: child) ] ].
		
	^ self cachedFor: aPosition type: itemType dryRun: dryRun context: aContext