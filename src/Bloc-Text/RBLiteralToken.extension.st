Extension { #name : 'RBLiteralToken' }

{ #category : '*Bloc-Text' }
RBLiteralToken >> acceptVisitor: aVisitor [

	^ aVisitor visitLiteralToken: self
]
