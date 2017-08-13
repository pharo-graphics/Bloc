examples
exampleVertical
	| space element |
	
	element := self new linearVertical.
	element forceLayout.

	space := BlSpace new.
	space extent: element extent.
	space root addChild: element.
	space show