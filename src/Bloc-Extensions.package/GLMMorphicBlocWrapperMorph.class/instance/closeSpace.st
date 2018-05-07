api
closeSpace
	self space hasHostSpace
		ifTrue: [ self space close ]