children add/remove
detachChild: anElement
	"Detaches anElement from myself. Detaching an element should be followed either by attachChild: or removeDetachedChild:
	Detachment should only be temporary; reattachment or removal should happen within the same drawing cycle as detachment.
	When an element is detached, its parent is nil and cannot be retrieved using `children at:`
	I must not be used within removeChild: because I have completely different intent; I meant to be temporary, while
	removeChild: is permanent.
	I don't clean focus in order to be able to preserve it in case child is attached back.
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement isNotNil.
	self assert: anElement parent == self.

	anElement parent: nil.
	self children remove: anElement