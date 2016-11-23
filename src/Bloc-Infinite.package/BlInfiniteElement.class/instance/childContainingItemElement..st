children - accessing
childContainingItemElement: anElement
	"Traverses the ancestors of the given element and returns the item view that contains it and
	also my direct child. Returned element can be used to get the ElementHolder by sending #childHolderOf:
	Return nil if such element was not found"
	<return: #BlElement or: nil>
	| aParent aPreviousParent |

	aParent := anElement parent.
	[ aParent isNotNil and: [ aParent ~~ self ] ] whileTrue: [ 
		aPreviousParent := aParent.
		aParent := aPreviousParent parent ].
	
	^ aParent == self
		ifTrue: [ aPreviousParent ]
		ifFalse: [ nil ]