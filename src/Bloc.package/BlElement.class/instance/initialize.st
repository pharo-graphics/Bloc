initialization
initialize
	super initialize.
	boundsCache := BlBoundsCache on: self.
	transform := SpartaMatrix new.
	eventDispatcher := BlBubblingEventDispatcher on: self.
	zIndex := 10.
	constraints := BlLayoutCommonConstraints new.
	dirty := true.
	self resetChildrenArray.
	geometry := self defaultPath.
	border := BlBorder empty.
	background := Color transparent asBlBackground.
	layout := self defaultLayout.
	pathCache := BlPathCache on: self.
	geomResizer := self defaultPathResizer.
	misc := BlMiscProperties new