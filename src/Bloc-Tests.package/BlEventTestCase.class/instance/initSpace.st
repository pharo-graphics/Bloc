initialization
initSpace
	space := BlSpace new extent: 200 @ 200.
	space mouseProcessor: (BlTestMouseEventProcessor space: space).
	space focusProcessor: (BlTestFocusProcessor space: space).
	space root addChild: (BlElement new size: 100 @ 100; background: Color red).
	space pulse