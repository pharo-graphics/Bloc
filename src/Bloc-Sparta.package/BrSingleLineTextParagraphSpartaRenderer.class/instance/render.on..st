rendering
render: aBrTextParagraph on: aSpartaCanvas
	aBrTextParagraph spans
		do: [ :aBrSpan | self render: aBrTextParagraph span: aBrSpan on: aSpartaCanvas ].
	
	self renderSelection: aBrTextParagraph on: aSpartaCanvas