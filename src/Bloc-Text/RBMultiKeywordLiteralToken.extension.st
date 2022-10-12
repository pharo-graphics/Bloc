Extension { #name : #RBMultiKeywordLiteralToken }

{ #category : #'*Bloc-Text' }
RBMultiKeywordLiteralToken >> acceptVisitor: aVisitor [

	^ aVisitor visitMultiKeywordLiteralToken: self
]
