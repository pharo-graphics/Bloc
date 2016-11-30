hooks - layout
onExitLayoutOrScroll
	
	layoutOrScrollCounter := layoutOrScrollCounter - 1.

	layoutOrScrollCounter < 0
		ifTrue: [
			self error: 'layout or scroll counter cannot go below zero'.
			"it is important anyway to set counter to 0"
			layoutOrScrollCounter := 0 ]