opening
openInWindow: anElement named: aTitleString extent: aPoint
	"Open a given element in a window of a provided extent and specified title"
	| aSpace |
	aSpace := BlSpace new
		extent: aPoint;
		title: aTitleString.
	
	aSpace root background: self spaceBackground.
	aSpace root addChild: anElement.

	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	aSpace show