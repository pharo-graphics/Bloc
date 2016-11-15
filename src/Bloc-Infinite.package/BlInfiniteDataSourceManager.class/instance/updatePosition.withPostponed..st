private
updatePosition: aPosition withPostponed: aCommand
	|pos|
	pos := aPosition.
	
	postponedCommands do: [ :postponed |
		pos := postponedCommands updatePosition: pos with: aCommand ].
	
	postponedCommands copy reverseWithIndexDo: [ :postponed :i | 
		postponed isMove
			ifTrue: [ 
				(postponed itemCount = postponed positionStart
					or: [ postponed itemCount < 0 ])
						ifTrue: [ 
							postponedCommands removeAt: i.
							self recycleCommand: postponed ] ]
			ifFalse: [ 
				postponed itemCount <= 0
					ifTrue: [ 
						postponedCommands removeAt: i.
						self recycleCommand: postponed ] ] ].
	^ pos