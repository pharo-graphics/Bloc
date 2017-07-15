cursor - management
moveCursorUp: anElement
	| focusFinder focusUp |
	
	focusFinder := BlFocusFinder new.
	focusUp := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionUp new.
	focusUp ifNotNil: #transferFocus