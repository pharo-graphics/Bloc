event firing
notifyWithEvent: anEvent
	"Fire a given event ensuring that it will happen in UI Thread"


	self flag: 'Find a solution'.

	BlUniverse default isUIProcess
		ifTrue: [ self fireEvent: anEvent ]
		ifFalse: [ self fireEvent: anEvent ]