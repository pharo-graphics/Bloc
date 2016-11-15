element fetching
elementFor: aPosition dryRun: dryRun context: aContext
	| holder fromScrap |
	
	fromScrap := false.
	holder := self positionedScrapFor: aPosition type: BlInfiniteItemType invalid dryRun: dryRun context: aContext.
	holder
		ifNotNil: [
			(self validateHolder: holder context: aContext)
				ifFalse: [
					dryRun ifFalse: [ 
						holder flagInvalid: true.
						holder isScrap
							ifTrue: [ 
								aContext childRemoved: holder itemElement.
								holder itemElement removedFromOwner: aContext.
								holder unscrap ]
							ifFalse: [ holder wasReturnedFromScrap
								ifTrue: [ holder flagReturnedFromScrap: false ] ].
							aContext recycler privateRecycleHolder: holder ].
					holder := nil ]
				ifTrue: [
					fromScrap := true ] ].

	^ holder
		ifNotNil: [ holder -> fromScrap ]
		ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun context: aContext ] ]