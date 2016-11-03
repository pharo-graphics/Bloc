path building
pathOn: aCanvas
	"Returns path or builds it if nil"

	^ aCanvas createPath: [ :aBuilder | self buildPathOn: aBuilder within: self geomBounds ]