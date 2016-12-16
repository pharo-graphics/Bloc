focus navigation
nextFocusable
	| lastFocusOwner newFocusable|
	lastFocusOwner := self space focusProcessor lastFocusOwner.
	newFocusable := self nextFocusableFrom: lastFocusOwner.
	^ newFocusable ifNil: [ self space root ].