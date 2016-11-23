children accessing
childTypeOf: anElement
	"Returns the element type defined by the datasource"

	^ (self childHolderOf: anElement) itemType