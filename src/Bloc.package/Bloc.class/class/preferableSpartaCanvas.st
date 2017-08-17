accessing
preferableSpartaCanvas
	^ PreferableSpartaCanvasBuilder ifNil: [
		PreferableSpartaCanvasBuilder := (self environment at: #BlSpartaRenderer) defaultCanvasBuilder class ]