pulse
initStart
	
	children ifEmpty: [ ^ self ].
	(children at: currentIndex) initStart.
	super initStart.