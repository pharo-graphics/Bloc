rendering
renderSelection: aBrTextParagraph on: aSpartaCanvas
	| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition aSelectionBounds |

	(aBrTextParagraph selection isEmpty)
		ifTrue: [ ^ self ].

	aStart := aBrTextParagraph selection	from.
	anEnd := aBrTextParagraph selection to min: aBrTextParagraph text size.

	aSelectionStartSpan := aBrTextParagraph spanAtIndex: aStart.
	aSelectionEndSpan := aBrTextParagraph spanAtIndex: anEnd.

	aSelectionStartPosition := aSelectionStartSpan positionAt: aStart.
	aSelectionEndPosition := aSelectionEndSpan positionAt: anEnd.

	aSelectionBounds := (aBrTextParagraph selection to > aBrTextParagraph text size)
		ifTrue: [ (aSelectionStartPosition x @ 0) corner: (aBrTextParagraph containerExtent x @ aBrTextParagraph height) ]
		ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ aBrTextParagraph height) ].

	aSpartaCanvas fill
		paint: ((Color r: 105 g: 171 b: 253 range: 255) alpha: 0.35);
		path: aSelectionBounds;
		draw