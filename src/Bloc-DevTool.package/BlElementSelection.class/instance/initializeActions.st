initialization
initializeActions
	
	removeButton := BlElementSelectionButton icon: BlIcons closeCircleSvg extent: 15@15.
	inspectButton := BlElementSelectionButton icon: BlIcons settingsSvg  extent: 15@15.
	resizeButton := BlElementSelectionButton icon: BlIcons arrowExpandAllSvg extent: 15@15.

	removeButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		"we will close automatically"
		self client removeFromParent ]).

	resizeButton addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt | evt consumed: true.]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEndEvent do: [ :evt |  evt consumed: true.]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt |
		evt consumed: true.
		self client size: (evt position - self client globalPosition) ]).

	inspectButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self client inspect]).
	
	self addChild: removeButton.
	self addChild: inspectButton.
	self addChild: resizeButton