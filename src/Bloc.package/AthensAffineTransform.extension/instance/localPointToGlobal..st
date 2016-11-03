*Bloc
localPointToGlobal: aPoint
	"Transform aPoint from local coordinates into global coordinates"
	self isIdentity ifTrue: [ ^ aPoint ].
	^ self transform: aPoint