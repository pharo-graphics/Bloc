change reporting
invalidRect: aDirtyRect from: anElement
	"Translate dirty reports from an Element"

	self isAttachedToSceneGraph
		ifFalse: [ ^ self ]
		ifTrue: [ self assertUIThread ].

	self space invalidRect: aDirtyRect from: anElement