examples
exampleGridRow
	| space element |
	
	element := (self >> #containerGridRow:visualHandler:) gtExample returnValue.
	
	space := BlSpace new.
	space extent: 955@600.
	space root addChild: element.
	space show