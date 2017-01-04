change reporting
invalidate
	"I mark my bounds as damaged area that should be redrawn on next rendering pass.
	Note, that #invalidate might be sent frequent, so keep implementation simple and performant.
	Try to avoid unnecessary object creation to not load garbage collector with much work"

	"If I am not added to scene graph, there is no need to invalidate damaged area"
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].
	
	self invalidRect: self boundsInSpace