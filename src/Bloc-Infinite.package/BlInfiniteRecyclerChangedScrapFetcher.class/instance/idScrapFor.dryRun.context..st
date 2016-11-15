private
idScrapFor: aPosition dryRun: dryRun context: aContext

	aContext dataSource hasStableIds ifTrue: [
		| offsetPosition |
		offsetPosition := aContext dataSourceController computePositionOffset: aPosition.
		(offsetPosition > 1 and: [ offsetPosition <= aContext dataSource itemCount ]) ifTrue: [ 
			|id|
			id := aContext dataSource itemIdAt: offsetPosition.
			aContext recycler changedScrap
				detect: [ :holder |
					holder wasReturnedFromScrap not and: [ holder itemId = id ] ]
				ifFound: [ :holder |
					holder flagReturnedFromScrap: true.
					^ holder ] ] ].
	^ nil