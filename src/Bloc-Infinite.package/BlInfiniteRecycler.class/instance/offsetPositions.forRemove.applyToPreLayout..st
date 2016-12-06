accessing - position
offsetPositions: aStartPosition forRemove: anItemCount applyToPreLayout: shouldApplyToPreLayout
	| removedEnd |
	
	removedEnd := aStartPosition + anItemCount.
	cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		anElementHolder position >= removedEnd
			ifTrue: [ anElementHolder offsetPositionBy: anItemCount negated applyToPreLayout: shouldApplyToPreLayout ]
			ifFalse: [
				anElementHolder flags addRemoved.
				self recycleCachedAt: anIndex ] ]