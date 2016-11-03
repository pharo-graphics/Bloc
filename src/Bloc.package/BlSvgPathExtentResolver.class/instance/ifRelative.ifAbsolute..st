path commands
ifRelative: aRBlock ifAbsolute: aABlock
	^ self isRelative
		ifTrue: aRBlock
		ifFalse: aABlock