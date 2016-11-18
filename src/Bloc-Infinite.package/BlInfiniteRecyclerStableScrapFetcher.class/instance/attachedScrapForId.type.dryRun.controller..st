private
attachedScrapForId: anItemId type: anItemType dryRun: dryRun controller: aRecyclerController

	aRecyclerController attachedScrap reverseWithIndexDo: [ :holder :index |
		(holder itemId = anItemId and: [ holder wasReturnedFromScrap not ]) ifTrue: [ 
			anItemType = holder itemType
				ifTrue: [ 
					holder flagReturnedFromScrap: true.
					(holder isRemoved and: [ aRecyclerController isPreLayout not ]) ifTrue: [ 
						holder flagUpdate: true.
						holder flagInvalid: false.
						holder flagRemoved: false ].
					^ holder ]
				ifFalse: [
					 dryRun ifFalse: [
						aRecyclerController attachedScrap removeAt: index.
						aRecyclerController childRemoved: holder itemElement.
						holder itemElement notifyRemovedFromParent.
						aRecyclerController quickRecycleScrap: holder itemElement ] ] ] ].
		
	^ nil