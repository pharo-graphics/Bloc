adding
add: aChild at: anIndex
	"Adds aChild at an index moving children to the right"
	array := array copyReplaceFrom: anIndex to: anIndex - 1 with: { aChild }.
	self arrayChanged