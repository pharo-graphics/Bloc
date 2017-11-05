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
	
	fromMatrix := self target transformation matrix.
	toMatrix := transformation matrix