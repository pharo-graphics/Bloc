api - selection
select: aFromIndex to: aToIndex
	"Add a new monotone selection merging it with existing ones within provided indices"
	
	self add: (BlSelection from: aFromIndex to: aToIndex)