initialization
initialize
	super initialize.
	
	self orientation: self defaultOrientation.
	self reverseLayout: self defaultReverseLayout.
	self stackFromEnd: self defaultStackFromEnd.
	layoutState := self defaultLayoutState.
	anchorInfo := self defaultAnchorInfo.
	
	"Initialize cache inst.vars"
	lastStackFromEnd := false.
	shouldReverseLayout := false.
	pendingScrollPosition := NoPosition.
	pendingScrollPositionOffset := self class invalidOffset