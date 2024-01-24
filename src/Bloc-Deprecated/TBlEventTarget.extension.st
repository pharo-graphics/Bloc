Extension { #name : #TBlEventTarget }

{ #category : #'*Bloc-Deprecated' }
TBlEventTarget >> when: anEventClass do: aBlock [


	self
		deprecated: 'Don t use it, this method cannot provide a determinist management of handler. Use add/remove event handler'
		transformWith: '`@rcv when: `@arg1 do: `@arg2' -> '`@rcv addEventHandler: ( BlEventHandler on: `@arg1 do: `@arg2 )'.
		
	self addEventHandler: (BlEventHandler on: anEventClass do: aBlock)
]
