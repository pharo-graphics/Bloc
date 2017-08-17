accessing
preferableSpartaCanvas: aBuilderClass
	PreferableSpartaCanvasBuilder := aBuilderClass.
	
	"change preferable universe host according to new setting"
	(self environment at: #BlSpartaRenderer) defaultCanvasBuilder: aBuilderClass new