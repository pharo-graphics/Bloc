enumeration
changesDo: aBlock
	"Evaluate a given block with every existing change as an argument"
	
	aBlock value: positionChange.
	aBlock value: extentChange