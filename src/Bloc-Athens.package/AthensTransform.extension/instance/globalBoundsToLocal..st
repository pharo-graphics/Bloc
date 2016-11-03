*Bloc-Athens
globalBoundsToLocal: aRectangle
	"Transform aRectangle from global coordinates into local coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (self globalPointsToLocal: aRectangle corners)