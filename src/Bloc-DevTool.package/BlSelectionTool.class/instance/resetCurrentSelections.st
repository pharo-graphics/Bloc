as yet unclassified
resetCurrentSelections
	currentSelections do: [ :each | each removeFromParent ].
	currentSelections removeAll.