helper
canFindInPreLayout: aPosition

	postponedCommands withIndexDo: [ :command :index | 
		command isMove
			ifTrue: [ 
				(self findPositionOffset: command itemCount firstPostponedItem: index + 1) = aPosition
					ifTrue: [ ^ true ] ]
			ifFalse: [ command isAdd
				ifTrue: [ 
					| end |
					end := command positionStart + command itemCount.
					command positionStart to: end - 1 do: [ :pos |
						(self findPositionOffset: pos firstPostponedItem: index + 1) = aPosition
							ifTrue: [ ^ true ] ] ] ] ].
	^ false