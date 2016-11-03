geometry bounds convertion
localBoundsToGlobal: aRectangle
	self parent ifNil: [ ^ self transform localBoundsToGlobal: aRectangle ].
	^ self parent localBoundsToGlobal: (self transform localBoundsToGlobal: aRectangle)