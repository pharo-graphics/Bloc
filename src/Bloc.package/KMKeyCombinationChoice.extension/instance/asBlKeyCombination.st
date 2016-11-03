*Bloc
asBlKeyCombination
	^ BlCombinationAlternative 
		withAll: (self collect: [ :each | each asBlKeyCombination ])