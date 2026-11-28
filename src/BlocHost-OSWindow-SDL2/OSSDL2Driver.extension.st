Extension { #name : #OSSDL2Driver }

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2Driver >> reset [

	super reset.
	self shutdownEventLoop
]
