pulse
initStart
	super initStart.
	children ifEmpty: [ ^ self ].
	(children at: currentIndex) initStart