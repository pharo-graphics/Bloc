adding / removing
select: aFromIndex to: aToIndex
	"Add a new monotone selection merging it with existing ones within provided indices"
	
	self add: (BlTextSelection from: aFromIndex to: aToIndex)