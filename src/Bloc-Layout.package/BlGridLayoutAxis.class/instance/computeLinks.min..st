computing links
computeLinks: links min: isMin
	
	links valuesDo: [ :span | span reset ].
	self groupBounds values withIndexDo: [ :bounds :index |
		|size span|
		size := bounds size: isMin.
		span := links at: index.
		span value: (span value max: ( isMin ifTrue: [ size ] ifFalse: [ size negated ] ) ) ].