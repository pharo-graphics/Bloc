private - scrolling
scrollState: aScrollState
	"Internal! Never set me directly"

	 scrollState = aScrollState
		ifTrue: [ ^ self ].

	scrollState := aScrollState.
	scrollState ~= ScrollSettling
		ifTrue: [ self stopScrollersInternal ].

	self dispatchScrollStateChanged: aScrollState