accessing
originalText
	^ originalText ifNil: [ originalText := self text asString ]