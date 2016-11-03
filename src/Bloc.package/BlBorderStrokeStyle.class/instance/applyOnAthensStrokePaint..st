applying
applyOnAthensStrokePaint: aStrokePaint
	self flag:#mitterLimitIsMissing.
	self lineJoin applyOnAthensStrokePaint: aStrokePaint.
	self lineCap applyOnAthensStrokePaint: aStrokePaint.
	"aStrokePaint miterLimit: self miterLimit."
	aStrokePaint dashes: self dashArray offset: self dashOffset