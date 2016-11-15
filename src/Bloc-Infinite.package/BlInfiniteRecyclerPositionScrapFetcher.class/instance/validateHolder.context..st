private
validateHolder: aHolder context: aContext

	aHolder isRemoved ifTrue: [ 
		aContext state isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder!' ].
		^ aContext state isPreLayout ].
		
	(aHolder position <= 0 or: [ aHolder position > aContext dataSource itemCount ])
		ifTrue: [ Error signal: 'Holder has completely wrong position!' ].
	
	aContext state isPreLayout ifFalse: [ 
		| type |
		type := aContext dataSource itemTypeAt: aHolder position.
		type = aHolder itemType
			ifFalse: [ ^ false ] ].

	^ aContext dataSource hasStableIds
		ifTrue: [ aHolder itemId = aContext dataSource itemIdAt: aHolder position ]
		ifFalse: [ true ]