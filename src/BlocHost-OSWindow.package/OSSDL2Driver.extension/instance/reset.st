*BlocHost-OSWindow
reset 
	super reset.
	EventLoopProcess ifNotNil: [ EventLoopProcess terminate ].