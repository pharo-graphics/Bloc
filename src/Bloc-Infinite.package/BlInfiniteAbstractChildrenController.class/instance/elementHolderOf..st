manager -> element
elementHolderOf: anElement
	"Return an element holder of the child element.
	ElementHolder can not be nil"
	<return: #BlInfiniteElementHolder>

	^ self subclassResponsibility