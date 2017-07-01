examples
exampleFlow
	| space element |
	
	element := self new composedFlow.
	element forceLayout.
	
	space := BlSpace new.
	space extent: element extent.
	space root addChild: element.
	space show