initialization
initialize
	super initialize.
	
	self text: (SpText fromString: (String loremIpsum: 10000))