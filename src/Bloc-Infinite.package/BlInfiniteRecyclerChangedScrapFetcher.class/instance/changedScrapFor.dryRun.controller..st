private
changedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController

	(aRecyclerController hasChangedScrap)
		ifFalse: [ ^ nil ].
	
	^ (self positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController)
		ifNil: [ self idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController ]