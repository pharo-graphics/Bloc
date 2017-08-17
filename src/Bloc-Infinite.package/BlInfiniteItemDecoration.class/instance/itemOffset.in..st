geometry
itemOffset: anItemElement in: anInfiniteElement
	"Retrieve any offsets for the given item element.
	If this ItemDecoration does not affect the positioning of item element, it should return empty insets"
	<return: #BlInsets>
	
	^ BlInsets empty