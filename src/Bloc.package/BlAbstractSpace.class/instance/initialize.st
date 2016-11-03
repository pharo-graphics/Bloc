initialize-release
initialize
	super initialize.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.
	root := self defaultRoot.
	glass := BlElement new space: self.
	rootStyler := self defaultRootStyler.
	self extent: self defaultExtent.
	self position: 10@10.
	self resizable: true.
	self borderless: false.
	nextPulseRequested := true.
	self initDispatcher.
	self updateCursorImage: Cursor normal
	