private - event loop
stopEventLoop
|aGdkEventFunc|
	"Terminate and destroy Gtk event loop"
	
	self
		assert: [ EventLoopProcess isNotNil ]
		description: [ 'Event loop must exist!' ].

	EventLoopProcess terminate.
	EventLoopProcess := nil.
	
	"re-plug the default gdk event handler"
	aGdkEventFunc := GdkEventFunc on: [ :evtPtr :data |
		Gtk primMainDoEvent: (GdkEvent fromHandle: evtPtr).].
	Gdk eventHandlerSet: aGdkEventFunc data: nil notify: nil.