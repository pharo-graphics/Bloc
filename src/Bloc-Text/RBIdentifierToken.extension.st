Extension { #name : #RBIdentifierToken }

{ #category : #'*Bloc-Text' }
RBIdentifierToken >> acceptVisitor: aVisitor [

	^ aVisitor visitIdentifierToken: self
]
