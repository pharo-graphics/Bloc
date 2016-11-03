*Bloc-Sparta
localBoundsToGlobal: aRectangle
	"Transform aRectangle from local coordinates into global coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (aRectangle corners collect:[:pt| self transform: pt])