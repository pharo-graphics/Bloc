children add/remove
attachChild: anElement
	"Attaches previously detached element as my last direct child.
	@see #attachChild:at: for more info"

	self attachChild: anElement at: self childrenCount + 1