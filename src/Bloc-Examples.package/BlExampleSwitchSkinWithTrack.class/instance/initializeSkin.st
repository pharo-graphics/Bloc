initialization
initializeSkin
	super initializeSkin.

	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 4).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: (BlRectangle new).

	widget size: 36@14.

	thumb := self newThumbElement.
	track := self newTrackElement.

	widget addChildren: { track . thumb }.
	
	self updateColor.
	self updateCornerRadius