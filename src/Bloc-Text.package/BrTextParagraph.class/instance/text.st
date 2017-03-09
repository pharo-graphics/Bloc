paragraph - accessing
text
	"Return the text I am assigned to"
	<return: #BrText>

	self
		assert: [ text isNotNil ]
		description: [ 'Text must never be nil' ].

	^ text