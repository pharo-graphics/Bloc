Extension { #name : #RBLiteralArrayToken }

{ #category : #'*Bloc-Text' }
RBLiteralArrayToken >> acceptVisitor: aVisitor [

	^ aVisitor visitLiteralArrayToken: self
]
