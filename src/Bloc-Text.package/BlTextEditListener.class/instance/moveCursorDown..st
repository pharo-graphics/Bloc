cursor - management
moveCursorDown: anElement
	| focusFinder focusDown |
	
	focusFinder := BlFocusFinder new.
	focusDown := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionDown new.
	focusDown ifNotNil: #transferFocus