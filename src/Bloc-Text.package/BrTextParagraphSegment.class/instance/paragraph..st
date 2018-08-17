accessing
paragraph: aTextParagraph

	self
		assert: [ aTextParagraph isNotNil ]
		description: [ 'Text paragraph must not be nil' ].

	paragraph := aTextParagraph