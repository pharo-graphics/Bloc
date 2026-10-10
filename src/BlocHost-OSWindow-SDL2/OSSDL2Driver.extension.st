Extension { #name : #OSSDL2Driver }

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2Driver >> ensureEventLoop [
	"Ensure that the SDL2 event loop process is running."

	"A dead process can linger across image sessions or crashes without being nilled.
	Only a living, non-terminated process indicates an active event loop."
	(EventLoopProcess isNotNil and: [ EventLoopProcess isTerminated not ])
		ifTrue: [ ^ self ].

	self shutdownEventLoop.
	self setupEventLoop
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2Driver >> reset [

	super reset.
	self shutdownEventLoop
]
