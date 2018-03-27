*Bloc
character: aCharacter
	<return: #KeyboardKey>

	^ KeyTable
		at: aCharacter asUnicode
		ifAbsent: [ self basicNew
			withValue: aCharacter asUnicode
			andName: self unknownKeyName ]