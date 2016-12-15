children add/remove
addChildFirst: anElement
	"Add anElement as my first direct child and request layout update.
	anElement must not be a direct child of any other element!
	anElement must not be nil"

	self addChild: anElement at: 1