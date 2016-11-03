initialization
initialize
	super initialize.
	
	cellSpacing := self defaultCellSpacing.
	orientation := self defaultOrientation.
	alignment := self defaultAlignment.

	impl := BlGridLayoutImpl on: self