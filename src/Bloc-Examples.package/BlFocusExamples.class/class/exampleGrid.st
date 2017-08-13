examples
exampleGrid
	| space element |
	
	element := self new grid.
	element forceLayout.
	
	space := BlSpace new.
	space extent: element extent.
	space root addChild: element.
	space show