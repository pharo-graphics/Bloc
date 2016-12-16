focus navigation
previousFocusable
	| lastFocusOwner newFocusable|
	lastFocusOwner := self space focusProcessor lastFocusOwner.
	newFocusable := self previousFocusableFrom: lastFocusOwner.
	^ newFocusable ifNil: [ self space root ].