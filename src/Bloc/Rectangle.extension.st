Extension { #name : 'Rectangle' }

{ #category : '*Bloc' }
Rectangle >> asBlocFloatRectangle [
	^ self origin asFloatPoint corner: self corner asFloatPoint
]
