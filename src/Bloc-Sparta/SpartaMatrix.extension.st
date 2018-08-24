Extension { #name : #SpartaMatrix }

{ #category : #'*Bloc-Sparta' }
SpartaMatrix >> globalBoundsToLocal: aRectangle [
	"Transform aRectangle from global coordinates into local coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (aRectangle corners collect:[:pt| self inverseTransform: pt])
]

{ #category : #'*Bloc-Sparta' }
SpartaMatrix >> localBoundsToGlobal: aRectangle [
	"Transform aRectangle from local coordinates into global coordinates"
	self isIdentity ifTrue: [ ^ aRectangle ].
	^ Rectangle encompassing: (aRectangle corners collect:[:pt| self transform: pt])
]

{ #category : #'*Bloc-Sparta' }
SpartaMatrix >> scale: aScalePoint [
	sx := aScalePoint x.
	sy := aScalePoint y
]
