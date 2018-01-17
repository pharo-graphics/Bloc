initialization
initialize
	super initialize.
	
	nextPulseRequested := true.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	self initDispatcher.
	
	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.

	root := self defaultRoot.
	glass := self defaultGlass.

	rootStyler := self defaultRootStyler.

	self extent: self defaultExtent.
	self position: 0@0.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self title: self defaultTitle.

	self updateCursorImage: Cursor normal.

	self root space: self.
	self glass space: self