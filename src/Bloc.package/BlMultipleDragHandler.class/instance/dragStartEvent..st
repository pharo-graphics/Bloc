dnd handlers
dragStartEvent: anEvent

"	theDraggedItems := anEvent currentTarget childrenCount timesCollect: [  BlDragItem new ].
	theDraggedItems
		ifEmpty: [ ^ self ].

	theDraggedItems
		with: anEvent currentTarget children
		do: [ :aDragItem :aSourceElement | aDragItem dragSession: (BlDragSession new sourceElement: aSourceElement)].
	anEvent consumed: true.

	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new dragItems: theDraggedItems)."
	
	anEvent consumed: true.

	delegate items: (anEvent currentTarget children collect: [ :aChild | BlDragItem new sourceElement: aChild ]).
	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new delegate: delegate; position: anEvent position)