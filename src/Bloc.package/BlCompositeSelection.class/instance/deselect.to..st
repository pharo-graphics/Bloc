api - selection
deselect: aFromIndex to: aToIndex
	"Remove a monotone selection within provided indices"
	
	self remove: (BlSelection from: aFromIndex to: aToIndex)