rendering
renderSelection: aBrTextParagraph on: aSpartaCanvas
	
	(aBrTextParagraph selection isEmpty)
		ifTrue: [ ^ self ].

	aBrTextParagraph selection do: [ :aSelection |
		| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition aSelectionBounds |
		
		aStart := aSelection	from.
		anEnd := aSelection to min: aBrTextParagraph text size.

		aSelectionStartSpan := aBrTextParagraph spanAtIndex: aStart.
		aSelectionEndSpan := aBrTextParagraph spanAtIndex: anEnd.

		aSelectionStartPosition := aSelectionStartSpan positionAt: aStart.
		aSelectionEndPosition := aSelectionEndSpan positionAt: anEnd.

		aSelectionBounds := (aSelection to > aBrTextParagraph text size)
			ifTrue: [ (aSelectionStartPosition x @ 0) corner: aBrTextParagraph containerExtent ]
			ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ aBrTextParagraph containerExtent y) ].

		aSpartaCanvas fill
			paint: ((Color r: 105 g: 171 b: 253 range: 255) alpha: 0.35);
			path: aSelectionBounds;
			draw ]

	