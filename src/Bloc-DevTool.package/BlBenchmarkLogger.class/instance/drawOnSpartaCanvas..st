drawing
drawOnSpartaCanvas: aCanvas
	| benchmarkString text |
	super drawOnSpartaCanvas: aCanvas.
		
	aCanvas transform during: [ :aTransform |
		aTransform translateBy: 5@5.
		aTransform apply.
		
		benchmarkString := (String streamContents: [ :aStream |
		self class benchmarks keysAndValuesDo: [ :name :duration |
			aStream nextPutAll: name asString, ': ', ((duration / 1000.0) asFloat printShowingDecimalPlaces: 1), 'ms', String cr ] ]) trimmed.

		text := SpText fromString: benchmarkString.
		text attributes: { SpFontGenericFamilyAttribute monospace. SpTextBackgroundAttribute paint: (Color white alpha: 1) }.

		text drawOn: aCanvas.
	]