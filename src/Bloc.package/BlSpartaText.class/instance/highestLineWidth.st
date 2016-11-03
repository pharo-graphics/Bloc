as yet unclassified
highestLineWidth
	| maxWidth  |
	maxWidth := 0.
	self layoutView lines do: [ :line | maxWidth := maxWidth max: line width ].
	^ maxWidth