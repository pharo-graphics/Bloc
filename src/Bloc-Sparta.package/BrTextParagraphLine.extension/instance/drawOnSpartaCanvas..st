*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	self spans do: [ :aSpan | aSpan drawOnSpartaCanvas: aCanvas ]