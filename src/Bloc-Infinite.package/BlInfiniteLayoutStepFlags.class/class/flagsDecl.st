flags declaration
flagsDecl
	"
	self rebuildFlagsAccessors
	"
	^ {
		#START -> 1.
		#LAYOUT -> (1 << 1).
		#ANIMATIONS -> (1 << 2).
	}