initialization
initialize
	super initialize.

	boundsCache := BlBoundsCache on: self.
	bounds := BlElementLocalBounds new referenceElement: self.
	measuredBounds := BlElementLocalBounds new referenceElement: self.

	eventDispatcher := BlBubblingEventDispatcher on: self.
	zIndex := 0.
	constraints := BlLayoutCommonConstraints new.
	self resetChildrenArray.

	transform := self defaultTransformation.
	geometry := self defaultGeometry.
	geomResizer := self defaultPathResizer.
	outskirts := self defaultOutskirts.
	border := self defaultBorder.
	background := self defaultBackground asBlBackground.
	layout := self defaultLayout.
	elevation := self defaultElevation.

	pathCache := BlPathCache on: self.
	misc := BlMiscProperties new.
	opacity := 1.0