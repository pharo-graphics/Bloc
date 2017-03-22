initialization
metrics: aMetrics
	
	box := aMetrics textMetrics bounds.
	"actual ascent consists not only from font ascent but also from fallback fonts ascent (box top abs)"
	ascent := box top negated max: aMetrics fontMetrics emAscent.
	descent := box bottom negated max: aMetrics fontMetrics emDescent.
	width := aMetrics textMetrics advance.
	strikethroughOffset := aMetrics fontMetrics strikeoutOffset.
	strikethroughSize := aMetrics fontMetrics strikeoutSize.

	height := ascent + descent