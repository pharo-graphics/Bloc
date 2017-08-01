*Bloc-Sparta
createSpartaTextPainter: aBrSpan on: aSpartaCanvas
	^ (super createSpartaTextPainter: aBrSpan on: aSpartaCanvas)
		breakNone;
		yourself