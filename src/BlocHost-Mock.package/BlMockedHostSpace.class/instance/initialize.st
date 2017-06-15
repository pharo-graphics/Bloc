initialization
initialize
	super initialize.

	eventFetcher := BlHostEventFetcher new.

	visible := false.
	minimized := false.
	maximized := false.
	borderless := false.
	opened := false.

	canvasExtent := self defaultCanvasExtent.
	windowExtent := self defaultWindowExtent.
	densityDpi := self defaultDensityDpi