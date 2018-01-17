I am a scriptable event handler that allows users to assign a valuable action to the event of chosen type.

Example:

[[[
BlEventHandler
	on: BlClickEvent
	do: [ :anEvent | self inform: 'Click!' ]
]]]