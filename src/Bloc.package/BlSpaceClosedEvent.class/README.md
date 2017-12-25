I am sent by a space after it is closed.

Example:

[[[
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceClosedEvent
	do: [ self inform: 'Space closed' ].
space show
]]]