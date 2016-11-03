*Bloc-Athens
pathOnAthensCanvas: aCanvas
	"Returns path or builds it if nil"

	^ aCanvas createPath: [ :aBuilder | self buildAthensPathOn: aBuilder within: self geomBounds ]