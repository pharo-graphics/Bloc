private
stableScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController

	^ (self attachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController)
		ifNil: [ self cachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController ]