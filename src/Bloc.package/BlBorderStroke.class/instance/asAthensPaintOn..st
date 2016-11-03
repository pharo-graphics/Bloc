converting
asAthensPaintOn: aCanvas
	| aPaint |
	aPaint := aCanvas surface createStrokePaintFor: (self paint asAthensPaintOn: aCanvas).
	aPaint width: self width + (self width/3) asFloat.
	self style applyOnAthensStrokePaint: aPaint.
	^ aPaint