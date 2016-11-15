private
getLastMoveOutOfOrderIn: aListOfCommands
	"Return an index of last move command which is not on right
	place - if there are any non-move command after move command
	in the list, or return 0 if there is no such move command"
	<return: #Number>
	
	| foundNonMove |
	foundNonMove := false.
	
	aListOfCommands reverseWithIndexDo: [ :command :index |
		command isMove
			ifTrue: [ foundNonMove ifTrue: [ index ] ]
			ifFalse: [ foundNonMove := true ] ].
	^ 0