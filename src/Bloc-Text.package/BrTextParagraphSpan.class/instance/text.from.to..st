initialization
text: aBrText from: aTextStart to: aTextEnd
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	from := aTextStart.
	to := aTextEnd