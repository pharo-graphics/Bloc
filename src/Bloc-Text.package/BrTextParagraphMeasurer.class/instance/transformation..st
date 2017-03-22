transformation - accessing
transformation: aBlTransformation
	"Change transformation that should be taken into account during future measurements.
	Once set, I additionally compute inverted transformation that is also used as part of measurement process.
	Note: for performance optimisation reasons if provided transformation is identity I set both my transformation
	and inverted transformation to nil. Before accessing my current transformation users must check if I have one
	by sending #hasTransformation"
	
	aBlTransformation isIdentity
		ifTrue: [ transformation := nil. inverseTransformation := nil ]
		ifFalse: [ transformation := aBlTransformation copy. inverseTransformation := transformation inverted ]