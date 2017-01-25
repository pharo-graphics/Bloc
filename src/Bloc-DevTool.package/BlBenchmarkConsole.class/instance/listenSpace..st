initialization
listenSpace: aSpace
	| lastTime frames framesLimit |
	lastTime := 0.
	frames := 0.
	framesLimit := 30.
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceRenderEndEvent do: [ :evt | 
				frames := frames + 1.
				frames % framesLimit = 0
					ifTrue: [
						self fps: (1000.0 /( ((evt end - lastTime) / framesLimit) max:1)) ceiling.
						lastTime := evt end.
						frames := 0 ].
				self renderTime: (evt end - evt start) ]).
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceEventProcessEndEvent do: [ :evt | 
					self eventProcessingTime: (evt end - evt start). 
					  ]).
  	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceLayoutEndEvent do: [ :evt | 
					self layoutTime: (evt end - evt start). 
					  ])