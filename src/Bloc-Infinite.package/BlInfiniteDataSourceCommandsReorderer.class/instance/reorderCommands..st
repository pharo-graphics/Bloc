sorting
reorderCommands: aListOfCommands
	| badMove |
	[ (badMove := self getLastMoveOutOfOrderIn: aListOfCommands) ~= 0 ]
		whileTrue: [ self swapMoveCommandIn: aListOfCommands badMoveIndex: badMove nextIndex: badMove + 1 ]