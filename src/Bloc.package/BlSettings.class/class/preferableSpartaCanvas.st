accessing
preferableSpartaCanvas
	^ PreferableSpartaCanvasBuilder ifNil: [ (self environment at: #BlSpartaRenderer) defaultCanvasBuilder ]