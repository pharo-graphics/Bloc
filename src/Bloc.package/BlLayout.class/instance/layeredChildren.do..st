enumeration
layeredChildren: anElement do: aBlock
	"Evaluate a given block with all children of anElement
	that should be layered out within anElement.
	By default only children that are not ignored by layout are layered"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout not ]
		thenDo: aBlock