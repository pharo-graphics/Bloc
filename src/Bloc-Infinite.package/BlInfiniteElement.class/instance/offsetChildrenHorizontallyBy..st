children - geometry
offsetChildrenHorizontallyBy: aNumber
	
	childrenManager childrenDo: [ :anElement |
		| previousPosition newPosition |
		previousPosition := anElement position.
		newPosition := (previousPosition x + aNumber) @ previousPosition y.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent.
		anElement commitChanges.
		
		self
			assert: [ newPosition closeTo: anElement position ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]