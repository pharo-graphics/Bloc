comparing
= aCombinationAlternative
	self class = aCombinationAlternative class ifFalse: [ ^ false ].
	^ self alternative includesAll: aCombinationAlternative alternative