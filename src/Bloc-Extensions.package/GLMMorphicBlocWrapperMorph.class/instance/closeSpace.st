api
closeSpace
	self space
		ifNil: [ ^ self ].

	self space hasHostSpace
		ifTrue: [ self space close ]