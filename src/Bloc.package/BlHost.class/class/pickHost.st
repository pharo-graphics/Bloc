driver selection
pickHost
	self allSubclassesDo: [ :s | s isSupported ifTrue: [ ^ s new ] ].
	Error signal: 'No host is available'