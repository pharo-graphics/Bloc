change reporting
invalidRect: aSpartaRectangle from: anElement
	"Translate dirty reports from an Element.
	A rectangle is given in my own coordinates"

	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	"transform provided rectangle to my parent's coordinates before I pass it further"
	self localBoundsToParent: aSpartaRectangle.
	self hasParent
		ifTrue: [ self parent invalidRect: aSpartaRectangle from: anElement ]
		ifFalse: [ self space invalidRect: aSpartaRectangle from: anElement ]