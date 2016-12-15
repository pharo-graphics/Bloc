accessing
initializeHandlers
self
			addEventHandler: (BlEventHandler on: BlDblClickEvent do: [ :evt | 
					evt consumed: true.
					self delete ]);
			addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt | 
					
					evt consumed: true.
					(self space root childIndexOf: self client) isZero
						ifFalse: [ self space root removeChild: self client ].
					self space root addChild: self client.
					self dragOffset: (evt position -  self client globalPosition).
					self clientUpdated.
					]);
			addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt | |pt|
					evt consumed: true.
					pt :=  ((evt position - self dragOffset) + (5 @ 5)).
					self client relocate: pt.
					self clientUpdated.
					 ])