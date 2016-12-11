children - add/remove
addAnimatingChild: anElementHolder
	"Adds a element to the animatingElements list.
	animatingElements holds the child elements that are currently being kept around
	purely for the purpose of being animated out of view. They are drawn as a regular
	part of the child list of the InfiniteElement, but they are invisible to the Layout
	as they are managed separately from the regular child elements"
	| anElement alreadyParented |
	
	anElement := anElementHolder itemElement.
	alreadyParented := anElement parent == self.
	
	recycler unscrapHolder: (self childHolderOf: anElement).
	anElementHolder isTmpDetached
		"re-attach"
		ifTrue: [ childrenManager attachChild: anElement at: 0 hidden: true ]
		ifFalse: [ alreadyParented
			ifFalse: [ childrenManager addChild: anElement hidden: true ]
			ifTrue: [ childrenManager hide: anElement ] ]