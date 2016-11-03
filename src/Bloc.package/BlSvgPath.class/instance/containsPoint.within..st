geometry testing
containsPoint: aPoint within: aBounds
	| scaleFactor translation |
	scaleFactor := aBounds extent / self extent.
	translation := aBounds origin - self position.
	^ self geomBounds containsPoint: aPoint / scaleFactor - translation