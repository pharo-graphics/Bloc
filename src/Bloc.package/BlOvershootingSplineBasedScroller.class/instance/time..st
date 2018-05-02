accessing
time: aBlTime
	"Set a new time provider"
	
	time == aBlTime
		ifTrue: [ ^ self ].
	
	time := aBlTime.
	self startTime: self time now