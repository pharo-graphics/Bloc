instance creation
rope: aRope from: aStart to: anEnd
	(aRope isNotEmpty and: [ aStart < 0 or: [ anEnd > aRope size ] ])
		ifTrue: [ self error: 'Iterator interval out of bounds!' ].
	(aRope isEmpty and: [ aStart ~= 0 or: [ anEnd ~= 0 ] ])
		ifTrue: [ self error: 'Iterator interval out of bounds!' ].

	rope := aRope.
	start := aStart min: anEnd.
	end := anEnd max: aStart.