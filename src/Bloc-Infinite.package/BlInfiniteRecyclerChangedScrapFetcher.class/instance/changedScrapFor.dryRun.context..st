private
changedScrapFor: aPosition dryRun: dryRun context: aContext

	(aContext recycler changedScrap isNil or: [ aContext recycler changedScrap isEmpty ])
		ifTrue: [ ^ nil ].
	
	^ (self positionedScrapFor: aPosition dryRun: dryRun context: aContext)
		ifNil: [ self idScrapFor: aPosition dryRun: dryRun context: aContext ]