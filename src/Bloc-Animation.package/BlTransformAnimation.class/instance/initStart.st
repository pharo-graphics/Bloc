pulse
initStart
	super initStart.

	isAbsolute
		ifFalse: [
			| aCompositeTransformation |
			aCompositeTransformation := BlElementCompositeTransformation new.
			aCompositeTransformation add: self target transformation.
			aCompositeTransformation add: transformation.
			transformation := aCompositeTransformation ].
	
	transformation owner: self target.
	
	self target topMostParent forceLayout.
	fromMatrix := self target transformation matrix.
	toMatrix := transformation matrix