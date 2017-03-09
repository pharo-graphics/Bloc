formatting
addStyle: styleSymbol forNode: anRBNode
	"Style a piece of text that represents a given node for a provided style name"

	self
		addAttributes: (self attributesFor: styleSymbol)
		forNode: anRBNode