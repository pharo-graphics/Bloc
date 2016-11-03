comparing
< aStyle
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)