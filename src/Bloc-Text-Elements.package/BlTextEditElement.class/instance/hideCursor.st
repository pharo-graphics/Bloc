cursor - management
hideCursor
	"hide all cursors"
	
	self hasCursor
		ifFalse: [ ^ self ].

	self removeChild: self cursor