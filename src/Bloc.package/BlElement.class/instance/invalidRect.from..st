change reporting
invalidRect: aDirtyRect from: aNode
	"Translate dirty reports from a node"

	self space ifNil: [ ^ self ].
	self space invalidRect: aDirtyRect from: aNode