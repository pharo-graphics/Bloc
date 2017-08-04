adding / removing
deselect: aFromIndex to: aToIndex
	"Remove a monotone selection within provided indices"
	
	self remove: (BlTextSelection from: aFromIndex to: aToIndex)