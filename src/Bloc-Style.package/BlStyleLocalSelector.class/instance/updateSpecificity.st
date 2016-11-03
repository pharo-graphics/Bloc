as yet unclassified
updateSpecificity
	idCount := 0.
	styleClassCount := self target styleClassProperty size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := 0.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount