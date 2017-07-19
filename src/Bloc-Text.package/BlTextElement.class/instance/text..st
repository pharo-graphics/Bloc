accessing
text: aTextModel
	"Change a text I represent.
	Note, that aTextModel should be an instance of SpText.
	aTextModel must not be nil"

	self
		assert: [ aTextModel isNotNil ]
		description: [ 'A text model must not be nil' ].

	text := aTextModel.
	"text attributes: { BrTextForegroundAttribute paint: Color transparent }."
	self textChanged