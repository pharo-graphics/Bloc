updating
updateSpecificity
	idCount := self matchesOnId asBit.
	styleClassCount := self styleClasses size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := self matchesOnName asBit.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount