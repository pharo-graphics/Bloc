examples
exampleHoriontal
	| space element |
	
	element := self new linearHorizontal.
	element forceLayout.
	
	space := BlSpace new.
	space extent: element extent.
	space root addChild: element.
	space show