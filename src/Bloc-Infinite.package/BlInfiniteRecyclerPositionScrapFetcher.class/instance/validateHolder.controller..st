private
validateHolder: aHolder controller: aRecyclerController

	aHolder isRemoved ifTrue: [ 
		aRecyclerController isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder!' ].
		^ aRecyclerController isPreLayout ].

	(aHolder position <= 0 or: [ aHolder position > aRecyclerController dataSourceItemCount ])
		ifTrue: [ Error signal: 'Holder has completely wrong position!' ].

	aRecyclerController isPreLayout ifFalse: [ 
		| type |
		type := aRecyclerController itemTypeAt: aHolder position.
		type = aHolder itemType
			ifFalse: [ ^ false ] ].

	^ aRecyclerController hasStableIds
		ifTrue: [ aHolder itemId = aRecyclerController itemIdAt: aHolder position ]
		ifFalse: [ true ]