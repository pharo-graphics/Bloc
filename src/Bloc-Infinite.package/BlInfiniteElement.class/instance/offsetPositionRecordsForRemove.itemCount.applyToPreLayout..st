private - commands
offsetPositionRecordsForRemove: aPositionStart itemCount: anItemCount applyToPreLayout: applyToPreLayout
	| aPositionEnd |

	aPositionEnd := aPositionStart + anItemCount.
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				anElementHolder position >= aPositionEnd
					ifTrue: [	anElementHolder
							offsetPositionBy: anItemCount negated
							applyToPreLayout: applyToPreLayout ]
					ifFalse: [ anElementHolder
						flagRemovedAndOffsetPosition: aPositionStart - 1
						by: anItemCount negated
						applyToPreLayout: applyToPreLayout ].
				state structureChanged: true ] ].

	recycler
		offsetPositionRecordsForRemove: aPositionStart
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.
	
	self requestLayout