helper
findPositionOffset: aPosition firstPostponedItem: firstPostponedItem
	|position|
	position := aPosition.
	
	firstPostponedItem to: postponedCommands size - 1 do: [ :index |
		| command |
		command := postponedCommands at: index.
		command isMove
			ifTrue: [ command positionStart = position
				ifTrue: [ position := command itemCount ]
				ifFalse: [ 
					command positionStart < position
						ifTrue: [ position := position - 1 ].
					command itemCount <= position
						ifTrue: [ position := position + 1 ] ] ]
			ifFalse: [
				command positionStart <= position ifTrue: [
					command isRemove
						ifTrue: [ 
							position < (command positionStart + command itemCount)
								ifTrue: [ ^ 0 ].
							position := position - command itemCount ]
						ifFalse: [
							command isAdd
								ifTrue: [ position := position + command itemCount ] ] ] ] ].
	^ position