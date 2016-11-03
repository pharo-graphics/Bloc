as yet unclassified
convertButtonFromMouseState: mouseState
	(mouseState bitAnd: SDL_BUTTON_LMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	(mouseState bitAnd: SDL_BUTTON_MMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent middleButton ].
	(mouseState bitAnd: SDL_BUTTON_RMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	(mouseState bitAnd: SDL_BUTTON_X1MASK) ~= 0
		ifTrue: [ ^ 4 ].
	(mouseState bitAnd: SDL_BUTTON_X2MASK) ~= 0
		ifTrue: [ ^ 5 ]