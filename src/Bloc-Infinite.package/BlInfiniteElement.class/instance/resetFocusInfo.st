private - focus
resetFocusInfo
	"Reset all stored focus information from my state"

	self state focusedItemId: NoId.
	self state focusedItemPosition: NoPosition.
	self state focusedSubChild: nil