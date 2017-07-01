*Bloc
character: aCharacter
	<return: #Key>

	^ KeyTable
		at: aCharacter asUnicode
		ifAbsent: [ self basicNew
			withValue: aCharacter asUnicode
			andName: self unknownKeyName ]