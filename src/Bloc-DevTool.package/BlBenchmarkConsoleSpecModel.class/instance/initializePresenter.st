initialization
initializePresenter
	| lastTime |
	lastTime := 0.
	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceRenderEndEvent do: [ :evt | 
					self renderTime label: (evt end - evt start) asString.
					self fps label: (1000/((evt end - lastTime) max: 1)) ceiling asString.
					lastTime := evt end.
					  ]).
	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceEventProcessEndEvent do: [ :evt | 
					self eventTime label: (evt end - evt start) asString. 
					  ]).
  	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceLayoutEndEvent do: [ :evt | 
					self layoutTime label: (evt end - evt start) asString. 
					  ])