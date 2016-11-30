flags declaration
flagsDecl
	"
	self rebuildFlagsAccessors
	"
	^ {
		#DISAPPEARED -> 1. 	"disappearing list"
		#APPEAR -> (1 << 1).	"appear in pre layout list"
		#PRE -> (1 << 2).		"pre layout, this is necessary to distinguish null item info"
		#POST -> (1 << 3).		"post layout, this is necessary to distinguish null item info"
	}