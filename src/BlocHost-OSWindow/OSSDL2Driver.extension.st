Extension { #name : #OSSDL2Driver }

{ #category : #'*BlocHost-OSWindow' }
OSSDL2Driver >> reset [ 
	super reset.
	EventLoopProcess ifNotNil: [ EventLoopProcess terminate ].
]
