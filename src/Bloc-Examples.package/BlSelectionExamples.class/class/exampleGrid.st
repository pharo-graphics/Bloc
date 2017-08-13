examples
exampleGrid
	| space element |
	
	element := (self >> #container:visualHandler:) gtExample returnValue.
	
	space := BlSpace new.
	space extent: 800@600.
	space root addChild: element.
	space show