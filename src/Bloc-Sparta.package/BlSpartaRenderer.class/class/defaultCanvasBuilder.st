accessing
defaultCanvasBuilder
	<return: #BlSpartaCanvasBuilder>

	^ defaultCanvasBuilder ifNil: [ defaultCanvasBuilder := self pickCanvasBuilderClass new ]