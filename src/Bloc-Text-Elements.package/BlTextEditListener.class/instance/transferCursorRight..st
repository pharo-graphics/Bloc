cursor - management
transferCursorRight: anElement
	| focusFinder focusRight |

	focusFinder := BlFocusFinder new.
	focusRight := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionRight new.
	focusRight ifNotNil: #transferFocus