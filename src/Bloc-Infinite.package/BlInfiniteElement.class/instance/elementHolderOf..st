children - accessing
elementHolderOf: anElement
	"Return an element holder assigned to anElement.
	anElement should not be necessarily my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteElementHolder>
	
	^ anElement constraints infinite holder