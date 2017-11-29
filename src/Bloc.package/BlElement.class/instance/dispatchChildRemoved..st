children dispatching
dispatchChildRemoved: anElement

	"First send hook to myself"
	self onChildRemoved: anElement.
	"Let child dispatch necessary events and hooks"
	anElement dispatchRemovedFromParent: self.
	
	"If an only if I am attached to scene graph we let child know
	that it is not a part of the scene graph anymore"
	self isAttachedToSceneGraph
		ifTrue: [ anElement dispatchRemovedFromSceneGraph ].