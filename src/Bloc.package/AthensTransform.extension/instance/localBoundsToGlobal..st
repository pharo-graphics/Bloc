*Bloc
localBoundsToGlobal: aRectangle
	"Transform aRectangle from local coordinates into global coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (self localPointsToGlobal: aRectangle corners)