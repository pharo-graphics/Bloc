children add/remove
removeDetachedChild: anElement
	"Finish the removal of a detached child. I will dispatch the remove event and notify the hierarchy changes.
	I am intended to be lightweight and make no assumptions about whether the parent or child should be redrawn.
	Proper use of me will include also making any appropriate #requestLayout or #changed message sends.
	I must not be used within removeChild: because I have completely different intent; I am used to balance temporary
	child detaching, while removeChild: is permanent."

	"send hook to the element that it was removed"
	self dispatchChildRemoved: anElement