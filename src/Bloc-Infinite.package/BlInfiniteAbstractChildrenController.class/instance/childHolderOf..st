manager -> element
childHolderOf: aChildElement
	"Return an element holder of child or nil
	if it does not have event holder associated"
	<return: #BlInfiniteElementHolder or: nil>

	^ self subclassResponsibility