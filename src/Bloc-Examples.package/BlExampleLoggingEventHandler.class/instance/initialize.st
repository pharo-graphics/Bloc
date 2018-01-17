initialization
initialize
	super initialize.
	
	counter := 0.
	self action: [ counter := counter + 1 ]