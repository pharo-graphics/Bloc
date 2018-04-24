instance creation
buildPathOnSpartaCanvas: aCanvas
	| newPathData pathBuilder|
	pathBuilder := aCanvas path.
	newPathData := self pathData"Within: aBounds".
	newPathData do: [ :each |  each executeOn: pathBuilder ].
	^ pathBuilder finish