hooks - children
onAddedToSceneGraph
	"Sent after one of my parents or I was added to scene graph, e.g. root element.
	At this point #isAttachedToSceneGraph results in true.
	Note: Always send onAddedToSceneGraph to super class if you override me!"
	
	self isFocused
		ifTrue: [ self requestFocus ].
		
	self space taskQueue enqueueFrom: self taskQueue