invalidation
elementRangeUpdate: aPosition itemCount: anItemCount
	| aPositionEnd |
	
	aPositionEnd := aPosition + anItemCount.
	self cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		| aLayoutPosition |
		aLayoutPosition := anElementHolder layoutPosition.
		(aLayoutPosition >= aPosition and: [ aLayoutPosition < aPositionEnd ])
			ifTrue: [ 
				anElementHolder flags addUpdate.
				self recycleCachedAt: anIndex.
				"cached elements should not be flagged as changed because this will cause them
				to animate when they are returned from cache." ] ]