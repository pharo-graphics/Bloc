accessing - position
offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: shouldApplyToPreLayout
	| removedEnd |
	
	removedEnd := aStartPosition + anItemCount.
	cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		anElementHolder position >= removedEnd
			ifTrue: [ anElementHolder
				offsetPositionBy: anItemCount negated
				applyToPreLayout: shouldApplyToPreLayout ]
			ifFalse: [ (anElementHolder position >= aStartPosition)
					ifTrue: [
						"Item for this element was removed. Dump it from the cache."
						anElementHolder flags addRemoved.
						self recycleCachedAt: anIndex ] ] ]