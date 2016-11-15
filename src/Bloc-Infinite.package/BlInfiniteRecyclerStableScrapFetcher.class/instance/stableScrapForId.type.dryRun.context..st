private
stableScrapForId: anItemId type: anItemType dryRun: dryRun context: aContext

	^ (self attachedScrapForId: anItemId type: anItemType dryRun: dryRun context: aContext)
		ifNil: [ self cachedScrapForId: anItemId type: anItemType dryRun: dryRun context: aContext ]