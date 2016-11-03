*Bloc
globalPointToLocal: aPoint
	"Transform aPoint from global coordinates into local coordinates"
	self isIdentity ifTrue: [ ^ aPoint ].
	^ self inverseTransform: aPoint