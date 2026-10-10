Extension { #name : #OSSDL3Driver }

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3Driver >> reset [

	super reset.
	self shutDownEventLoop
]
