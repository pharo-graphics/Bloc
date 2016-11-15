private
attachedScrapForId: anItemId type: anItemType dryRun: dryRun context: aContext

	aContext recycler attachedScrap reverseWithIndexDo: [ :holder :index |
		(holder itemId = anItemId and: [ holder wasReturnedFromScrap not ]) ifTrue: [ 
			anItemType = holder itemType
				ifTrue: [ 
					holder flagReturnedFromScrap: true.
					(holder isRemoved and: [ aContext state isPreLayout not ]) ifTrue: [ 
						holder flagUpdate: true.
						holder flagInvalid: false.
						holder flagRemoved: false ].
					^ holder ]
				ifFalse: [
					 dryRun ifFalse: [ 
						aContext recycler attachedScrap removeAt: index.
						aContext childRemoved: holder itemElement.
						holder itemElement removedFromOwner: aContext.
						aContext recycler quickRecycleScrap: holder itemElement ] ] ] ].
		
	^ nil