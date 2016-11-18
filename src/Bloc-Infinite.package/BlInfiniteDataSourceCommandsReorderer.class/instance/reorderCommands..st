reordering
reorderCommands: aListOfCommands
	"In-place reorder provided list of commands.
	I am used by data source manager during commands processing step.
	Return a reordered list of commands (the same instance)"
	<return: #Collection>
	
	| badMove |
	
	"Since move commands break continuity, their effects on add/remove are hard to handle.
	We push them to the end of the list so that they can be handled easily."
	[ (badMove := self getLastMoveOutOfOrderIn: aListOfCommands) ~= 0 ]
		whileTrue: [ self swapMoveCommandIn: aListOfCommands badMoveIndex: badMove nextIndex: badMove + 1 ].
	^ aListOfCommands