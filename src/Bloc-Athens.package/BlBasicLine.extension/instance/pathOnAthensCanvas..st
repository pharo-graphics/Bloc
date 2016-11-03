*Bloc-Athens-drawing
pathOnAthensCanvas: aCanvas
	"Returns path or builds it if nil"

	^ aCanvas createPath: [ :aBuilder | self buildPathOnAthensBuilder: aBuilder ]