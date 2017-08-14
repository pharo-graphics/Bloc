enumeration
measuredChildren: anElement do: aBlock
	"Evaluate a given block with all children of anElement
	that should be taken into account during measurement process.
	By default only children that are not ignored by layout are measured"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout not ]
		thenDo: aBlock