api
onWindowClosed

	self space hasHostSpace
		ifTrue: [ self space close ]