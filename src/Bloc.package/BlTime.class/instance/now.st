api - time
now
	"Return a 'current' date and time, it is not necessarily a real one"
	<return: #DateAndTime>

	^ frozen
		ifTrue: [ frozenTime ]
		ifFalse: [ self currentTime ]