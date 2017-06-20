initialization
initializeWithAttributes: initialAttributes
	window := OSWindowAnimated createWithAttributes: initialAttributes.
	window eventHandler: (BlOSWindowEventHandler window: self)