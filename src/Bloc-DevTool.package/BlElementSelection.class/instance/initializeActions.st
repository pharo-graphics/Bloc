accessing
initializeActions
|previousPos|
	tlBtn := BlElementSelectionButton icon: BlIcons closeCircleSvg extent: 15@15.
	trBtn := BlElementSelectionButton icon: BlIcons rotateLeftSvg extent: 15@15.
	blBtn := BlElementSelectionButton icon: BlIcons settingsSvg  extent: 15@15.
	brBtn := BlElementSelectionButton icon: BlIcons arrowExpandAllSvg extent: 15@15.
	
	tlBtn addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		self client removeFromParent.
		self removeFromParent]).
	
	brBtn addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt | evt consumed: true.]).
	brBtn addEventHandler: (BlEventHandler on: BlDragEndEvent do: [ :evt |  evt consumed: true.]).
	brBtn addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt | ||
					evt consumed: true.
					self client extent: (evt position - self client globalPosition).
					self extent: (self client geomBoundsInSpace extent + (10@10)).
					self updateActionsPosition.
					]).
				
	blBtn addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self client inspect]).
	trBtn addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt | 
		evt consumed: true.
		previousPos := evt position. ]).
	
	trBtn addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt | 
		| ptPos pivot theta a2 a1|
		evt consumed: true.
		ptPos := (evt position -15).
		pivot := evt target geomBoundsInSpace origin.
		a1 := (ptPos y - pivot y) arcTan: (ptPos x - pivot x).
		a2 := (previousPos y - pivot y) arcTan: (previousPos x - pivot x).
		theta := (a2 - a1).
		self client centerRotateByRadians: theta negated.
		previousPos := ptPos.
		]).
	
	self addChild: tlBtn.
	self addChild: trBtn.
	self addChild: blBtn.
	self addChild: brBtn