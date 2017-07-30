rendering
renderSelection: aBrTextParagraph on: aSpartaCanvas
	| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition |
	
	aBrTextParagraph selection
		ifEmpty: [ ^ self ].
	
	aStart := aBrTextParagraph selection	first.
	anEnd := aBrTextParagraph selection last.
		
	aSelectionStartSpan := aBrTextParagraph spanAtIndex: aStart.
	aSelectionEndSpan := aBrTextParagraph spanAtIndex: anEnd.
	
	aSelectionStartPosition := aSelectionStartSpan positionAt: aStart.
	aSelectionEndPosition := aSelectionEndSpan positionAt: anEnd.

	aSpartaCanvas fill
		paint: (Color blue alpha: 0.2);
		path: ((aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ aBrTextParagraph height));
		draw