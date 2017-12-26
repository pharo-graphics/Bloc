initialization
initializeSkin
	super initializeSkin.

	widget size: 14@14.
	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 3).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: BlEllipse new.

	thumb := self newThumbElement.

	widget addChild: thumb.

	self updateColor