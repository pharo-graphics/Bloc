initialization
setUp
	super setUp.
	
	space := BlSpace new.
	processor := BlKeyboardProcessor new.
	processor space: space