*Bloc-Athens
buildAthensPathOn: aPathBuilder within: aBounds
	| newPathData |
	newPathData := self pathDataWithin: aBounds.
	newPathData do: [ :each | aPathBuilder perform: each first withArguments: each second ]