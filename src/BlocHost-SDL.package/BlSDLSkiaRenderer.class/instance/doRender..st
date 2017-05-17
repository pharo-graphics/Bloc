rendering
doRender: aSpace
	
	self prepareForDrawing.
	dirtyAreas := aSpace dirtyAreas.
	self drawDuring: [ :aCanvas | aSpace fullDrawOn: aCanvas ].
	self present.