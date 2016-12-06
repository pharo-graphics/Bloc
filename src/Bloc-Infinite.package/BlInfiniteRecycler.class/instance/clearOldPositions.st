recycling
clearOldPositions

	self cachedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ].

	self attachedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ].
	
	self changedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ]