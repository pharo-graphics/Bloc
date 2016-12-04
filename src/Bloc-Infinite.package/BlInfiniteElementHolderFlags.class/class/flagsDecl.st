flags declaration
flagsDecl
	"
	self rebuildFlagsAccessors
	"
	^ {
		#BOUND -> (1 << 0).
		#UPDATE -> (1 << 1).
		#INVALID -> (1 << 2).
		#REMOVED -> (1 << 3).
		#NOT_RECYCLABLE -> (1 << 4).
		#RETURNED_FROM_SCRAP -> (1 << 5).
		#IGNORE -> (1 << 7).
		#TMP_DETACHED -> (1 << 8).
		#DATA_SOURCE_POSITION_UNKNOWN -> (1 << 9).
		#DATA_SOURCE_FULL_UPDATE -> (1 << 10).
		#MOVED -> (1 << 11).
		#APPEARED_IN_PRE_LAYOUT -> (1 << 12).
		#BOUNCED_FROM_HIDDEN_LIST -> (1 << 13).
		#PENDING_ACCESSIBILITY_STATE_NOT_SET -> (-1).
	}