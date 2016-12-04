flags declaration
flagsDecl
	"
	self rebuildFlagsAccessors
	"
	^ {
		#ADD -> 1.
		#REMOVE -> (1 << 1).
		#UPDATE -> (1 << 2).	
		#MOVE -> (1 << 3).
	}