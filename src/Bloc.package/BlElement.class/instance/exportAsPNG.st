converting
exportAsPNG
	| fName |
	fName := UIManager default request:'Please enter the name' translated initialAnswer: self externalName,'.png'.
	fName isEmptyOrNil ifTrue:[^self].
	PNGReadWriter putForm: self asForm onFileNamed: fName.