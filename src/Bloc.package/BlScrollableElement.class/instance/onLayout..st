layout
onLayout: aBounds
	self scrollFlinger isIdle
		ifFalse: [ ^ super onLayout: aBounds ].
	
	"first we fix a gap"	
	self layoutFixGap.

	"now clamp position"
	self layoutClampPosition.
	
	"then we allign content if it is smaller than the scrollpane"
	self layoutApplyAlignment.

	super onLayout: aBounds