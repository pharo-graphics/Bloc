children - add/remove
attachChild: anElement at: anIndex
	"Reattach a previously detached child element.
	If anIndex == 0 child will be attached at the end"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	self
		assert: [ anElementHolder isNotNil ]
		description: [ 'Temporary detached child must have element holder' ].

	anElementHolder isRemoved
		ifTrue: [ self addToDisappearedInLayout: anElementHolder ]
		ifFalse: [ self removeFromDisappearedInLayout: anElementHolder ].

	childManager attachChildToParent: anElement at: anIndex hidden: anElementHolder isRemoved