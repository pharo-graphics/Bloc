children add/remove
addChild: anElement at: anIndex
	"If anIndex == 0 child will be added at the end"

	self addChild: anElement at: anIndex disappearing: false