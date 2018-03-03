initialization
span: aBrSpan of: aTextParagraph on: aCanvas
	"Prepare and configure me for a given text span within a paragraph"

	textParagraph := aTextParagraph.
	textSpan := aBrSpan.
	textRun := aBrSpan asString.