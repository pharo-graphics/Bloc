rendering
doRender: aSpace
	
	self prepareForDrawing.
	self drawDuring: [ :aCanvas | aSpace fullDrawOn: aCanvas ].
	self present.
	self clearDirtyAreasFor: aSpace.