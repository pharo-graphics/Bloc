comparing
= anotherObject
	self species == anotherObject species
		ifFalse: [ ^ false ].

	^ anotherObject eventClass = self eventClass
		and: [ anotherObject action = self action ]