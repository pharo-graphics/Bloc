formatting
addStyle: aStyleSymbol from: aStart to: anEnd
	"Style a piece of text from aStart to anEnd for a provided style name"

	self
		addAttributes: (self attributesFor: aStyleSymbol)
		from: aStart
		to: anEnd