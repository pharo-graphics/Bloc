initialization
initialize
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.

	"by default there are no arrow heads.
	For memory and performance reasons we do not initialize 'null object' heads"
	fromHead := nil.
	toHead := nil.

	self clipChildren: false