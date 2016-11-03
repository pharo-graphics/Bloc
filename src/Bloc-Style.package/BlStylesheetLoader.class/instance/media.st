grammar media
media
	^ super media
		==>
			[ :nodes | 
			BlStyleMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]