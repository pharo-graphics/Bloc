pulse
initStart
	children ifEmpty: [ ^ self ].
	children do: [ :each | each initStart ].
	super initStart.