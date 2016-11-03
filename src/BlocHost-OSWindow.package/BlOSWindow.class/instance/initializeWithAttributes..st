initialize-release
initializeWithAttributes: initialAttributes
	window := OSWindow createWithAttributes: initialAttributes.
	self initHostWindow.
	