children - accessing
childHolderContainingItemElement: anElement
	"Return the ElementHolder that contains the given element.
	Return nil if the provided element is not a my descendant"
	<return: #BlInfiniteHolder or: nil>
	| aChildElement |

	aChildElement := self childContainingItemElement: anElement.
	^ aChildElement ifNotNil: [ :anItemElement |
		self childHolderOf: anItemElement ]