as yet unclassified
listenSpace: aSpace
	| lastTime |
	lastTime := 0.
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceRenderEndEvent do: [ :evt | 
					self renderTime: (evt end - evt start).
					self fps: (1000/((evt end - lastTime) max:1)) ceiling.
					lastTime := evt end.
					  ]).
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceEventProcessEndEvent do: [ :evt | 
					self eventProcessingTime: (evt end - evt start). 
					  ]).
  	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceLayoutEndEvent do: [ :evt | 
					self layoutTime: (evt end - evt start). 
					  ])