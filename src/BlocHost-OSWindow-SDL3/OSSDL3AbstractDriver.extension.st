Extension { #name : #OSSDL3AbstractDriver }

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3AbstractDriver >> reset [

	super reset.
	self shutDownEventLoop
]
