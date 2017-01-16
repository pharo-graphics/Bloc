children dispatching
dispatchChildAdded: anElement
	
	"First send hook to myself"
	self onChildAdded: anElement.
	"Let child dispatch necessary events and hooks"
	anElement dispatchAddedToParent.

	"If an only if I am attached to scene graph we let child know
	that it is a part of the scene graph now"
	self isAttachedToSceneGraph
		ifTrue: [ anElement dispatchAddedToSceneGraph ].