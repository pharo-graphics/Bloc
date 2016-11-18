private
exactScrapFor: aPosition type: itemType dryRun: dryRun controller: aRecyclerController

	^ aRecyclerController attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder layoutPosition = aPosition 
				and: [ holder isInvalid not
					and: [ aRecyclerController isPreLayout
						or: [ holder isRemoved not ] ] ] ]) ]
		ifFound: [ :holder | 
			(itemType = BlInfiniteItemType invalid
				or: [ holder itemType = itemType ])
					ifFalse: [ 
						Error signal: 'Scrap holder has wrong item type!' ].
			holder flagReturnedFromScrap: true.
			holder ]
		ifNone: [ nil ]