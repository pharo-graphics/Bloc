initialization
initialize
	super initialize.
	currentSelections := OrderedCollection new.
	selectionRect := BlElement new
		zIndex: 1000;
		size: 50@50;
		background: Color transparent;
		border:
			(BlBorder
				paint: Color black
				width: 1
				radius: 0
				style: BlStrokeStyle DOTTED);
		yourself