children - adding
add: aChild at: anIndex
	"Adds aChild at a given index moving existing children to the right"

	rope := rope insertItems: { aChild } at: anIndex - 1