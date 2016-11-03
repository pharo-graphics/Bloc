*Bloc-Sparta
globalBoundsToLocal: aRectangle
	"Transform aRectangle from global coordinates into local coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (aRectangle corners collect:[:pt| self inverseTransform: pt])