initialization
initialize
	super initialize.
	
	margin := BlInsets empty.
	padding := BlInsets empty.

	maxHeight := Float infinity.
	maxWidth := Float infinity.
	minHeight := 0.
	minWidth := 0.
	
	ignoredByLayout := false.
	
	"Initialzed lazily in at:"
	constraints := nil