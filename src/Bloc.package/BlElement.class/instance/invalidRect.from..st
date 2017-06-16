change reporting
invalidRect: aBlBounds from: anElement
	"Translate dirty reports from an Element.
	A rectangle is given in my own coordinates"

	"we are guarding owerselves from unnecessary computations of rectangle transformation"
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	"transform provided rectangle to my parent's coordinates before I pass it further"
	self localBoundsToParent: aBlBounds.
	self hasParent
		ifTrue: [ self parent invalidRect: aBlBounds from: anElement ]
		ifFalse: [ self space invalidRect: aBlBounds from: anElement ]