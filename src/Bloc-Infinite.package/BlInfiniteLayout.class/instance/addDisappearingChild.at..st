children add/remove
addDisappearingChild: anElement at: anIndex
	"If anIndex == 0 child will be added at the end
	@see #addDisappearingChild:"

	self addChild: anElement at: anIndex disappearing: true