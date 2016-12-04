flags declaration
flagsDecl
	"
	self rebuildFlagsAccessors
	"
	^ {
		#CHANGED -> [ BlInfiniteElementHolderFlags Update ].
		#REMOVED -> [ BlInfiniteElementHolderFlags Removed ].
		#INVALIDATED -> [ BlInfiniteElementHolderFlags Invalid ].
		#MOVED -> [ BlInfiniteElementHolderFlags Moved ].
		#APPEARED_IN_PRE_LAYOUT -> [ BlInfiniteElementHolderFlags AppearedInPreLayout ]
	}