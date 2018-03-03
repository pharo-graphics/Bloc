measurement
measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth
	| metricsLength howManyGlyphsFit measuredLength |
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	self
		assert: [ aTextRun isNotEmpty or: [ aTextRunStart isZero and: [ aTextRunEnd isZero ] ] ]
		description: [ 'If text run is empty start and end indices must be zero (end may be infinite)' ].

	self
		assert: [ aTextRunStart isInfinite not ]
		description: [ 'Text run start must be finite' ].

	self
		assert: [ (aTextRunStart between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run start must be less or equal to text run length' ].

	self
		assert: [ aTextRunEnd isInfinite not ]
		description: [ 'Text run end must be finite' ].

	self
		assert: [ (aTextRunEnd between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run end must be less or equal to text run length' ].
	
	metricsLength := aTextRun isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ aTextRunEnd - aTextRunStart + 1 ].
	
	howManyGlyphsFit := aWidth isInfinite
		ifTrue: [ metricsLength ]
		ifFalse: [ (aWidth / self glyphWidth) ceiling ].

	measuredLength := metricsLength min: howManyGlyphsFit.
	measuredWidth := measuredLength * self glyphWidth.
	measuredHeight := self height * measuredLength isZero not asBit.
	
	textRunStart := aTextRunStart.
	textRunEnd := aTextRunStart + measuredLength - aTextRun isNotEmpty asBit.