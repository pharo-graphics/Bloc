anchor - hooks
onFromAnchorMoved
	"I am sent when from-anchor moved"
	
	self requestLayout.
	
	ContextStackSignal emit