examples - compositor
mouseDownOnNodesBelowThePoint
	<gtExample>
	| theNodes mouseEvent theEvents |
	
	theEvents := OrderedCollection new.

	mouseEvent := BlMouseDownEvent new.
	mouseEvent timestamp: DateAndTime now.
	mouseEvent button: BlMouseEvent primaryButton.
	mouseEvent position: 20@20.

	theNodes := self nodesBelowThePoint.
	theNodes linksDo: [ :aNode |
		aNode
			addEventHandlerOn: BlMouseDownEvent
			do: [ :anEvent | theEvents add: anEvent ] ].

	theNodes firstLink fireEvent: mouseEvent.
	^ theEvents