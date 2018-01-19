copying
copyFrom: anEvent
	super copyFrom: anEvent.

	"We re-initialize traversed targets in order to support event convertion like #asClickEvent
	because the event that we are copying from might have already other traversed targets"
	traversedTargets := LinkedList new