cursor - management
showCursor
	"Show the cursor"

	self hasCursor
		ifTrue: [ ^ self ].

	self cursorExists
		ifFalse: [ cursorElement := self defaultCursor ].

	self addChild: self cursorElement