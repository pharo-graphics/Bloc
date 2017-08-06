initialization
text: aBrText from: aGlobalTextStart to: aGlobalTextEnd
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	from := aGlobalTextStart.
	to := aGlobalTextEnd