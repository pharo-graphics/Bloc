Extension { #name : 'RBBinarySelectorToken' }

{ #category : '*Bloc-Text' }
RBBinarySelectorToken >> acceptVisitor: aVisitor [

	^ aVisitor visitBinarySelectorToken: self
]
