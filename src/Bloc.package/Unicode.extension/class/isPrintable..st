*Bloc
isPrintable: aCharacter
	| value codeCat |

	value := aCharacter charCode.
	value > (GeneralCategory size - 1)
		ifTrue: [^ false].
	
	codeCat := GeneralCategory at: value + 1.
	^ (codeCat >= Cn and: [ codeCat <= Cs ]) not