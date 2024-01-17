Extension { #name : 'RBAssignmentToken' }

{ #category : '*Bloc-Text' }
RBAssignmentToken >> acceptVisitor: aVisitor [

	^ aVisitor visitAssignmentToken: self
]
