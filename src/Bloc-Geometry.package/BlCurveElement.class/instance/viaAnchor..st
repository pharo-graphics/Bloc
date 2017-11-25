anchor - accessing
viaAnchor: anAnchor
	"Add one more anchor between `from` and `to`".
	
	viaAnchors add: anAnchor.
	anAnchor
		addEventHandlerOn: BlAttachAnchorMoved
		do: [ :anEvent | self onAnchorMoved ].
	self onAnchorMoved