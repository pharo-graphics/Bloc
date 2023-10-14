Extension { #name : 'RBErrorToken' }

{ #category : '*Bloc-Text' }
RBErrorToken >> acceptVisitor: aVisitor [

	^ aVisitor visitErrorToken: self
]
