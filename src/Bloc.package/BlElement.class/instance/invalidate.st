change reporting
invalidate
	"I mark my bounds as damaged area that should be redrawn on next rendering pass.
	Note, that #invalidate might be sent frequent, so keep implementation simple and performant.
	Try to avoid unnecessary object creation to not load garbage collector with much work.
	You should clearly understand consequences of sending #invalidate. For example if element
	just changes its position the content does not change so you should send invalidation to the
	parent (also providing invalidated bounds in parent coordiantes) because only its content changes and not my own.
	Please, don't forget that elements or rendering backends may implement a rendering cache that
	is also invalidated on every #invalidate message sent, so use me wisely."

	"If I am not added to scene graph, there is no need to invalidate damaged area"
	"we are guarding owerselves from unnecessary computations of rectangle transformation"
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	self invalidRect: (self invalidationBounds: SpartaRectangle new)