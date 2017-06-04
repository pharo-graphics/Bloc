pulse
initStart
	
	children ifEmpty: [ ^ self ].
	currentIndex := 1.
	children do: [ :each | each initStart ].
	super initStart.