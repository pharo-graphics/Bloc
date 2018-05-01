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
	
	"matrix depends on computed layout bounds, we should manually trigger layout recomputation"
	self target space isLayoutRequested
		ifTrue: [ self target space doLayout ].

	fromMatrix := self target transformation matrix.
	toMatrix := transformation matrix