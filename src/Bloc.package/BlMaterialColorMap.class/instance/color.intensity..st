as yet unclassified
color: aSymbol intensity: anInteger
	^ ((colorMap at: aSymbol) at: anInteger)
		colorName: (aSymbol , anInteger asString) asSymbol;
		yourself