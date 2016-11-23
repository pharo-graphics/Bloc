children - accessing
childContainingItemElement: anElement
	"Traverses the ancestors of the given element and returns the item view that contains it and
	also my direct child. Returned element can be used to get the ElementHolder by sending #childHolderOf:
	Return nil if such element was not found or if the element is a child of the InfiniteElement but not a child of the InfiniteLayout
	which may happen if, for example, we are running a disappear animation"
	<return: #BlElement or: nil>
	| foundElement |
	
	foundElement := infiniteElement childContainingItemElement: anElement.
	^ foundElement
		ifNotNil: [ (childManager isHidden: foundElement)
			ifTrue: [ nil ]
			ifFalse: [ foundElement ] ]