initialization
rope: aRope segment: aSpanRope start: aStart end: anEnd from: aTextFrom to: aTextTo metrics: aMetrics transform: aSpartaMatrix transformInverted: anInvertedSpartaMatrix textRun: aTextRun attributes: theAttributes
	rope := aRope.
	span := aSpanRope.
	start := aStart.
	end := anEnd.
	from := aTextFrom.
	to := aTextTo.
	length := anEnd - aStart + 1.
	box := aSpartaMatrix localBoundsToGlobal: aMetrics textMetrics bounds.
	"actual ascent consists not only from font ascent but also from fallback fonts ascent (box top abs)"
	ascent := box top abs max: (aSpartaMatrix transformY: aMetrics fontMetrics emAscent).
	descent := box bottom abs max: (aSpartaMatrix transformY: aMetrics fontMetrics emDescent).
	width := (aSpartaMatrix transformX: aMetrics textMetrics advance) + aSpartaMatrix translation x.
	strikethroughOffset := aSpartaMatrix transformY: aMetrics fontMetrics strikeoutOffset.
	strikethroughSize := aSpartaMatrix transformY: aMetrics fontMetrics strikeoutSize.
	height := ascent + descent.
	transformation := aSpartaMatrix.
	transformationInverted := anInvertedSpartaMatrix.
	textRun := aTextRun.
	attributes := theAttributes