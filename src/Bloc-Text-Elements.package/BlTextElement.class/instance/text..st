accessing
text: aTextModel
	"Change a text I represent.
	Note, that aTextModel should be an instance of BrText.
	aTextModel must not be nil"

	self
		assert: [ aTextModel isNotNil ]
		description: [ 'A text model must not be nil' ].
		
	self
		assert: [ aTextModel isKindOf: BlText ]
		description: [ 'A text model must be an instance if Text' ].

	text := aTextModel.
	self textChanged