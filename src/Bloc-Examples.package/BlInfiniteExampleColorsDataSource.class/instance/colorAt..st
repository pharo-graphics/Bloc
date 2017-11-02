initialization
colorAt: anIndex
	| normalizedIndex |
	"0.0 <= anIndex <= 1.0"
	
	normalizedIndex := anIndex.
	"Because of float errors"
	normalizedIndex > 1 ifTrue: [ normalizedIndex := 1 ].
	normalizedIndex < 0 ifTrue: [ normalizedIndex := 0 ].
	
	^ Color
		r: (self redAt: normalizedIndex)
		g: (self greenAt: normalizedIndex)
		b: (self blueAt: normalizedIndex)