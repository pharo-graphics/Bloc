event firing
notifyWithEvent: anEvent
	"Fire a given event ensuring that it will happen in UI Thread"

	BlUniverse default isUIProcess
		ifTrue: [ self fireEvent: anEvent ]
		ifFalse: [ BlUniverse default animationManager
			addAnimation: (BlInfinitePostAction new action: [ self fireEvent: anEvent ]) ]