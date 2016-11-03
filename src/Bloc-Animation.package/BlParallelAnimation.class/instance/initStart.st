pulse
initStart
	super initStart.
	children ifEmpty: [ ^ self ].
	children do: [ :each | each initStart ]