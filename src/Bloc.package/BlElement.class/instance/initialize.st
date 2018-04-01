initialization
initialize
	super initialize.

	boundsCache := BlBoundsCache on: self.
	bounds := BlElementLocalBounds new referenceElement: self.
	measuredBounds := BlElementLocalBounds new referenceElement: self.
	changes := BlElementChanges new.

	eventDispatcher := BlBubblingEventDispatcher on: self.
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

	shouldHandleMouseEvents := true.
	shouldChildrenHandleMouseEvents := true.

	misc := BlMiscProperties new.
	misc label: self className.
	opacity := 1.0.
	
	taskQueue := BlTaskQueue new