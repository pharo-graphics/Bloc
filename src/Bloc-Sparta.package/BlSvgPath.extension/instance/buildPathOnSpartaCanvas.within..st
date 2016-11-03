*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
| newPathData pathBuilder|
	pathBuilder := aCanvas path.
	newPathData := self pathDataWithin: aBounds.
	newPathData do: [ :each |  pathBuilder perform: each first withArguments: each second ].
	pathBuilder close.
	^ pathBuilder finish