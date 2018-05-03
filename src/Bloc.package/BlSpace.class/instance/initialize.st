initialization
initialize
	super initialize.
	
	nextPulseRequested := true.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	eventRecorder := self defaultEventRecorder.
	self initDispatcher.
	
	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.

	tasks := BlTaskQueue new.
	time := BlTime real.

	root := self defaultRoot.

	rootStyler := self defaultRootStyler.

	self extent: self defaultExtent.
	self position: 0@0.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self title: self defaultTitle.

	self updateCursorImage: Cursor normal.

	self root space: self