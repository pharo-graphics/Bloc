as yet unclassified
mapSpecialCharacter: symbol
	^ SDL2SpecialCharacterMapping mapKeySymbol: symbol ifAbsent: [ ^ nil ]