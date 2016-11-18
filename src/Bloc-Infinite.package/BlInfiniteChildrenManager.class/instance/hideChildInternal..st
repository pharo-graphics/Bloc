hidden
hideChildInternal: aChildElement
	"Marks a child element as hidden"
	hiddenChildren add: aChildElement.
	controller onEnteredHiddenState: aChildElement