private - event loop
eventLoopProcess
	| event aGdkEventFunc session |
	session := Smalltalk session.
	
	aGdkEventFunc := GdkEventFunc on: [ :evtPtr :data |
		event := (GdkEvent fromHandle: evtPtr).
		self processEvent: event.
		Gtk primMainDoEvent: event.].
	
	Gdk eventHandlerSet: aGdkEventFunc data: nil notify: nil.
	
	[ session == Smalltalk session] whileTrue: [
		Gtk primEventsPending 
			ifTrue: [ Gtk primMainIterationDo: false. ]
			ifFalse: [ (Delay forMilliseconds: 5) wait ]
	]