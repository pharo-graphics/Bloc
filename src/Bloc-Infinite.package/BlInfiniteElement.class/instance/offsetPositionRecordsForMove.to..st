private - commands
offsetPositionRecordsForMove: aFromPosition to: aToPosition
	| aStart anEnd anInBetweenOffset|
	
	aFromPosition < aToPosition
		ifTrue: [
			aStart := aFromPosition.
			anEnd := aToPosition.
			anInBetweenOffset := -1 ]
		ifFalse: [ 
			aStart := aToPosition.
			anEnd := aFromPosition.
			anInBetweenOffset := 1 ].
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder position between: aStart and: anEnd)
			ifTrue: [ 
				anElementHolder position = aFromPosition
					ifTrue: [ anElementHolder offsetPositionBy: aToPosition - aFromPosition applyToPreLayout: false ]
					ifFalse: [ anElementHolder offsetPositionBy: anInBetweenOffset applyToPreLayout: false ].
				state structureChanged: true ] ].
	
	recycler offsetPositionRecordsForMove: aFromPosition to: aToPosition.
	self requestLayout