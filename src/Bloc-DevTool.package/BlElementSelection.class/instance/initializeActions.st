initialization
initializeActions
	| initialPosition initialSize |

	removeButton := BlElementSelectionButton icon: BlEllipse new extent: 12@12.
	removeButton opacity: 0.75.
	removeButton background: Color red.
	removeButton border: (BlBorder builder width: 1; paint: Color black; build).
	
	inspectButton := BlElementSelectionButton icon: BlEllipse new  extent: 12@12.
	inspectButton opacity: 0.75.
	inspectButton background: Color blue.
	inspectButton border: (BlBorder builder width: 1; paint: Color black; build).
	
	resizeButton := BlElementSelectionButton icon: BlEllipse new extent: 12@12.
	resizeButton opacity: 0.75.
	resizeButton background: Color yellow.
	resizeButton border: (BlBorder builder width: 1; paint: Color black; build).
	
	infoButton := BlElementSelectionButton icon: BlEllipse new extent: 12@12.
	infoButton opacity: 0.75.
	infoButton background: Color green.
	infoButton border: (BlBorder builder width: 1; paint: Color black; build).

	removeButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		"we will close automatically"
		self client removeFromParent ]).

	resizeButton addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt |
		initialPosition := evt position.
		initialSize := self client extent.
		evt consumed: true ]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEndEvent do: [ :evt |  evt consumed: true.]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt |
		evt consumed: true.
		self client size: (initialSize + evt position - initialPosition) ]).

	inspectButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self client inspect]).
	
	infoButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self toggleInfo ]).
	
	self addChild: removeButton.
	self addChild: inspectButton.
	self addChild: infoButton.
	self addChild: resizeButton