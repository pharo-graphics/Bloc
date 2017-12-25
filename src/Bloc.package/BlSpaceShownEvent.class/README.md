I am sent by a space after it is shown.

Example:

[[[
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceShownEvent
	do: [ self inform: 'Space shown' ].
space show
]]]

Note:
Behaves as SDL_WINDOWEVENT_SHOWN