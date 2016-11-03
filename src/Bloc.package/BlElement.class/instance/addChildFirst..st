children add/remove
addChildFirst: anElement
"Add anElement as my last direct child and request layout update (@see BlElement>>managedChildrenChanged).
	anElement must not be nil."
	self assert: anElement isNotNil.
	
	"update parent"
	anElement parent ifNotNil: [ :p | p removeChild: anElement ].
	anElement parent: self.
	"actually add child"	
	self children addFirst: anElement.
	"send hook after element has been added"
	anElement notifyAddedInParent.
	"finally requesting children changed"
	self managedChildrenChanged