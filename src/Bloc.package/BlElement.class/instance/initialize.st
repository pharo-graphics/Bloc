initialization
initialize
	super initialize.

	boundsCache := BlBoundsCache on: self.
	bounds := BlElementLocalBounds new referenceElement: self.
	measuredBounds := BlElementLocalBounds new referenceElement: self.
	changes := BlElementChanges new.

	eventDispatcher := BlBubblingEventDispatcher on: self.
	zIndex := 0.
	constraints := BlLayoutCommonConstraints new.
	self resetChildrenArray.

	transformation := self defaultTransformation owner: self.
	geometry := self defaultGeometry.
	geometryResizer := self defaultGeometryResizer.
	outskirts := self defaultOutskirts.
	border := self defaultBorder.
	background := self defaultBackground asBlBackground.
	backgroundResizer := self defaultBackgroundResizer.
	layout := self defaultLayout.
	elevation := self defaultElevation.

	pathCache := BlPathCache on: self.
	misc := BlMiscProperties new.
	misc label: self className.
	opacity := 1.0