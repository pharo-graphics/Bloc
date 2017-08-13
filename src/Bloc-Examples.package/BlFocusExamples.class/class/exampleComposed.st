examples
exampleComposed
	| space element |
	
	element := self new composed.
	element forceLayout.
	
	space := BlSpace new.
	space extent: element extent.
	space root addChild: element.
	space show