initialization
initializeHandlers
	self
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :anEvent | 
					anEvent consumed: true.
					self close ]).
	self
		addEventHandler:
			(BlEventHandler
				on: BlDragStartEvent
				do: [ :anEvent |
					| aClientOldGlobalPosition aClientNewGlobalPosition |
					anEvent consumed: true.
					
					aClientOldGlobalPosition := self client positionInSpace.
					aClientNewGlobalPosition := self space root globalPointToLocal: aClientOldGlobalPosition.
					aClientNewGlobalPosition := aClientNewGlobalPosition.
					
					"detach client from its current owner and attach it to the space root"
					self client invalidate.
					self client parent detachChild: self client.
					self space root attachChild: self client.
					self client relocate: aClientNewGlobalPosition.
					self client invalidate.
					
					"store drag start offset to allow us smooth dragging"
					self dragOffset: anEvent position - aClientNewGlobalPosition ]).
	self
		addEventHandler:
			(BlEventHandler
				on: BlDragEvent
				do: [ :anEvent | 
					| aPosition |
					anEvent consumed: true.
					aPosition := anEvent position - self dragOffset.
					self client relocate: aPosition ])