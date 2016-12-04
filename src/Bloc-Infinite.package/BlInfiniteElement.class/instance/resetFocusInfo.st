private - focus
resetFocusInfo
	"Reset all stored focus information from my state"

	self state focusedItemId: self class noId.
	self state focusedItemPosition: self class noPosition.
	self state focusedSubChild: nil