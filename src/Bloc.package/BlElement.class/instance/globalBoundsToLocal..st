geometry bounds convertion
globalBoundsToLocal: aRectangle
	self parent ifNil: [ ^ transform globalBoundsToLocal: aRectangle ].
	^ self parent globalBoundsToLocal: (transform globalBoundsToLocal: aRectangle)