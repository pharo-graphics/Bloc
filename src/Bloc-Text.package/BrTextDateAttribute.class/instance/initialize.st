initialization
initialize
	super initialize.
	formBlock := [ | morph |
	morph := CalendarMorph on: self date.
	morph extent: self extent.
	morph imageForm ].
	append := false.