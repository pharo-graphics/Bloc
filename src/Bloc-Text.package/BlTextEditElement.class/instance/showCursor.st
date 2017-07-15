cursor - management
showCursor
	"Show the cursor"

	self hasCursor
		ifTrue: [ ^ self ].

	self cursorExists
		ifFalse: [ cursor := self defaultCursor ].

	self addChild: self cursor