instance creation
empty: aBrText
	"Returns a sub-text that is backed up by an empty text"
	<return: #BlSubText>
	
	self
		assert: [ aBrText isEmpty ]
		description: [ 'Underlying text must be empty in order to create empty sub-text' ].
		
	^ self
		text: aBrText
		from: 0
		to: 0