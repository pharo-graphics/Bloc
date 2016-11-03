accessing
printOn: aStream
	|mods|
	mods := OrderedCollection new.
	self isAlt ifTrue: [ mods add: 'Alt'].
	self isCmd ifTrue: [ mods add:  'Cmd'].
	self isCtrl ifTrue: [ mods add:  'Ctrl'].
	self isShift ifTrue: [ mods add: 'Shift'].
	self isCapsLock ifTrue: [ mods add:  'CapsLock'].
	self isNumLock ifTrue: [ mods add:  'NumLock'].
	aStream nextPutAll: (mods joinUsing: $+) 
	
	