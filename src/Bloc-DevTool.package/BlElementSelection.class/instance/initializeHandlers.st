accessing
initializeHandlers
self
			addEventHandler: (BlEventHandler on: BlDblClickEvent do: [ :evt | 
					evt consumed: true.
					self delete ]);
			addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt | 
					
					evt consumed: true.
					self space root addChild: self client.
					self dragOffset: (evt position -  self position).
					self clientUpdated.
					]);
			addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt | 
					evt consumed: true.
					self client relocate: ((evt position - self dragOffset) + (5 @ 5)).
					self clientUpdated.
					 ])