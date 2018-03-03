accessing
text: aBrText
	self
		assert: [ text isNil ]
		description: [ 'Can not change text once it is set. Create a new instance instead' ].
		
	text := aBrText