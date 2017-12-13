accessing
originalText
	^ originalText ifNil: [ originalText := self text copy ]