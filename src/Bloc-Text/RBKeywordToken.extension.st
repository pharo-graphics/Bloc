Extension { #name : 'RBKeywordToken' }

{ #category : '*Bloc-Text' }
RBKeywordToken >> acceptVisitor: aVisitor [

	^ aVisitor visitKeywordToken: self
]
