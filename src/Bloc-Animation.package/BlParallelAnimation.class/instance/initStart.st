pulse
initStart
	animations ifEmpty: [ ^ self ].
	animations do: [ :each | each initStart ].
	super initStart.