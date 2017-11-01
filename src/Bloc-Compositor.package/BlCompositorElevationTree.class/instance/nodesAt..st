accessing
nodesAt: aPoint
	"Return a collection of rendering nodes located at a given point in space coordinates"
	| theNodes |
	
	theNodes := DoubleLinkedList new.
	self do: [ :aLayer | aLayer nodesAt: aPoint in: theNodes ].
	^ theNodes