accessing
char: aCharacter
	self 
		deprecated: 'Please use key: explicitly instead'
		transformWith: '`@receiver char: `@character' -> '`@receiver key: (Key character: `@character)'.
	self key: (Key character: aCharacter asLowercase)