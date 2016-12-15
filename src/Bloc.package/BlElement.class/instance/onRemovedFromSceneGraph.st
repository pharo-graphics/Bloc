children hooks
onRemovedFromSceneGraph
	"Sent after one of my parents or I was removed from scene graph, e.g. root element.
	At this point #isAttachedToSceneGraph results in false.
	Note: Always send onRemovedFromSceneGraph to super class if you override me!"