focus
initFocusedBounds: aFocusedBounds root: aFocusRootElement

	aFocusRootElement layout isRightToLeft
		ifTrue: [ aFocusedBounds
			left: aFocusRootElement width
			top: aFocusRootElement height
			right: aFocusRootElement width
			bottom: aFocusRootElement height ]
		ifFalse: [
			aFocusedBounds
				left: 0
				top: 0
				right: 0
				bottom: 0 ]