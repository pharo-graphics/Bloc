*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
| newPathData pathBuilder|
	pathBuilder := aCanvas path.
	newPathData := self pathData"Within: aBounds".
	newPathData do: [ :each |  pathBuilder perform: each first withArguments: each second ].
	^ pathBuilder finish