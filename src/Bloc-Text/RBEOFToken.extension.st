Extension { #name : #RBEOFToken }

{ #category : #'*Bloc-Text' }
RBEOFToken >> acceptVisitor: aVisitor [

	^ aVisitor visitEOFToken: self
]
