accessing - position
offsetPositions: aStartPosition forRemove: anItemCount applyToPreLayout: shouldApplyToPreLayout
	| removedEnd |
	
	removedEnd := aStartPosition + anItemCount.
	cachedScrap size to: 1 do: [ :anIndex |
		| aHolder |
		aHolder := cachedScrap at: anIndex.
		aHolder position >= removedEnd
			ifTrue: [ aHolder offsetPositionBy: anItemCount negated applyToPreLayout: shouldApplyToPreLayout ]
			ifFalse: [
				aHolder flags addRemoved.
				self recycleCachedAt: anIndex ] ]