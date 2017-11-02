cursor - management
transferCursorLeft: anElement
	| focusFinder focusLeft |

	focusFinder := BlFocusFinder new.
	focusLeft := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionLeft new.
	focusLeft ifNotNil: #transferFocus