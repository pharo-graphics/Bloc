measurement - testing
wantsMore
	"Return true if I there is enough space left or there are still not measured glyphs in a text run,
	false otherwise"
	<return: #Boolean>
	
	self
		assert: [ self text isNotEmpty or: [ self textRunStart isZero and: [ self textRunSize isZero ] ] ]
		description: [ 'If text is empty start and size must be zero' ].
		
	^ self text isEmpty
		ifTrue: [ false ]
		ifFalse: [ self textRunStart <= self textRunSize and: [ self availableWidth > 0 ] ]