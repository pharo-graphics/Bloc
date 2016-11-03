as yet unclassified
initialize
	super initialize.
	currentSelections := OrderedCollection new.
	selectionRect := BlElement new
		zIndex: 1000;
		extent: 50@50;
		background: Color transparent;
		border:
			(BlBorder
				color: Color black
				width: 1
				radius: 0
				style: BlBorderStrokeStyle DOTTED);
		yourself