initialization
initializeSkin
	super initializeSkin.

	widget size: 22@14.
	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 3).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: (BlRectangle cornerRadius: 8).

	thumb := self newThumbElement.

	widget addChild: thumb.

	self updateColor