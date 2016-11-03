change reporting
invalidRect: aDirtyRect from: anElement
	"Translate dirty reports from an Element"

	self space ifNil: [ ^ self ].
	self space invalidRect: aDirtyRect from: anElement