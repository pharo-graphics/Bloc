measurement
layout

	self spans
		ifEmpty: [ ^ self ].

	self spanAdded: self spans first.	
	2 to: self spans size do:
		[ :index | self spanAdded: (self spans at: index) after: (self spans at: index - 1) ]