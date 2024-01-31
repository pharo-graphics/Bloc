Extension { #name : 'RBNumberLiteralToken' }

{ #category : '*Bloc-Text' }
RBNumberLiteralToken >> acceptVisitor: aVisitor [

	^ aVisitor visitNumberLiteralToken: self
]
