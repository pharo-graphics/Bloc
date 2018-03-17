children - adding
add: aChild at: anIndex
	"Adds aChild at a given index moving existing children to the right"

	array := array copyReplaceFrom: anIndex to: anIndex - 1 with: { aChild }