*Bloc-Sparta
drawSelectionOnSpartaCanvas: aCanvas
	
	(self selection isNil or: [ self selection isEmpty ])
		ifTrue: [ ^ self ].

	self selection do: [ :aSelection |
		| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition aSelectionBounds |
		
		aStart := aSelection	from.
		anEnd := aSelection to min: self text size.

		aSelectionStartSpan := self spanAtIndex: aStart.
		aSelectionEndSpan := self spanAtIndex: anEnd.

		aSelectionStartPosition := aSelectionStartSpan positionAt: aStart.
		aSelectionEndPosition := aSelectionEndSpan positionAt: anEnd.

		aSelectionBounds := (aSelection to > self text size)
			ifTrue: [ (aSelectionStartPosition x @ 0) corner: self containerExtent ]
			ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ self containerExtent y) ].

		aCanvas fill
			paint: ((Color r: 105 g: 171 b: 253 range: 255) alpha: 0.35);
			path: aSelectionBounds;
			draw ]

	