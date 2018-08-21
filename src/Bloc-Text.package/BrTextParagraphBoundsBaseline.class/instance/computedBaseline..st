baseline
computedBaseline: aTextParagraph
	<return: #Point>

	^ 0 @ ((aTextParagraph ascent - (aTextParagraph bottom / 2.0) + aTextParagraph height) / 2.0)