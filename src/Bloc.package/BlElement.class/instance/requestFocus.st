focus requesting
requestFocus
	"Request a focus for this element.
	If I am not added to the scene graph mark me as focused in order to re-try focus
	request as soon I am added to the scene graph"

	self isAttachedToSceneGraph
		ifTrue: [ self requestFocus: self ]
		ifFalse: [ self focused: true ]