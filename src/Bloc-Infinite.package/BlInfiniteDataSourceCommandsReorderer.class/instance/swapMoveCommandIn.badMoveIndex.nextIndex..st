private
swapMoveCommandIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
	| badMoveCommand nextCommand |
	badMoveCommand := aListOfCommands at: badMoveIndex.
	nextCommand := aListOfCommands at: nextIndex.
	
	nextCommand swapMoveOn: self in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex