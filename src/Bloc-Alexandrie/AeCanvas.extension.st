Extension { #name : #AeCanvas }

{ #category : #'*Bloc-Alexandrie' }
AeCanvas >> fullDraw: anElement [
	"Render a space and return a collection of damaged rectangles"

	anElement aeFullDrawOn: self.
	self flush.
	
	^ #() "This is not the expected result"
]
